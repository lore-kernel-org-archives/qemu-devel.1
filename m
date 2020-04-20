Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E66BC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D772D206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D772D206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQYeL-00069Q-3b
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40606 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQYdQ-0005bm-Jw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:47:01 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQYdP-0008BG-VM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:47:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37845)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jQYdP-00088Q-8j
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:46:59 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MpDRv-1iseqj3lCp-00qiAD; Mon, 20 Apr 2020 17:46:51 +0200
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
To: frederic.konrad@adacore.com
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <429d6d9c-fff7-d64d-3dfb-917d1985ec90@vivier.eu>
Date: Mon, 20 Apr 2020 17:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9YtPHQ2umSSRKheJkBZ622gv9DYzL+BdiHYSLok9f7wtZKFtQcH
 3FHKpUugaINkSuPmSvSXXPj6KltrH0rRr0pr8o1yQUk79pxBtEM28Idnj0Hcf3PnveNm4NR
 JNwnOcCi0zKpyiDFakQ+N2LDU9QmxQsUYLErLBcnAS51BS1IKj3YDKVUUmJUCeX9SuJ6/Ca
 RPfU2QPmNf+tfg0gUjceA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2EVEvXIz0ko=:T01vGCMVZ4vKRK/b33yyQT
 bQbBFiDCGh2QEhQdaPqT+20/ij/5831lxElMYfPe7BcNZZTZ42d6qjwLxX16OSre5iuv6u3bq
 zaMfcsrOn52F+EZC7GK5Oz+kc8FmzMRLi6ac81aKYFla/MBHcKDJEvubDdzpeyTOs/L8IYFJb
 nwkuvalmmp9tbGkQo+84B+ZYE7nONScZvh3mMi5nts0tp11/GSnT7Hi7/VzFj2ZERD34O8a3i
 2iDZ4ZHy67Z5Jfjm9kC+8tnRC2R85B1u+tjR+cKPmMqcbSv4y21a6ACrfOLzIAqjI6Av2y8sb
 0HtvHQmE2dX+OHwrbOFoTFORSa7EZdjtuXXIJSGv6YoaxLYOVRnIp0wj/pTuZrFju+/DGjzQp
 wh6D666J/obMc/TbqwV7qaauLWGoMhXtjGqM51OXnIc83Ns85nQozFdH7GVVkkxuPFhv8WAgQ
 HQERjtc3amrklWiepU7xaMT9xkzwaqQD+qLVVKv9mH3v8H+D9+IktIVybwPucj1oSClxB4eyM
 ZxHEnZSAw5RF3eQ/0xL98onQ7VYo3hql6xyQ76LiRx32GIZ765Uj9rdhrLxJ5ulUEB+sW8/h8
 0FkX0/3+PYVnLeS+DuSXN7rXSmSzFvySj6UTnbYCe6kSu8RDRungghHRHO9fV/YMycbRLZhWy
 B9T4osZWgXUjiWHi20isjHu890U64xUpfro4vHm1+5lzL0O8UkjWTSdzMHDovqZzPpfDExNwL
 90xS1xNsDHuh7+VzLYxhDckmTrv01l0ikp5yKDembV4SdAvZqAmAM7p6lnHGrcEXRSrq7GP3k
 tkHuHLLlCnlS7c0LTH1Ei8dD/1Z9x99PZNoK/ksvZt2W8zyjp6CX4TAwzp3Qjhlzbb1F0k0
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 11:46:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.126.134
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: huth@tuxfamily.org, alex.bennee@linaro.org, f4bug@amsat.org,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pierre@freepascal.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
> a coldfire FPU instead of the default m68881 FPU.


I checked in gdb sources and there is no cf definition.

Moreover if I change only the cf to m68k in QEMU it seems to work in
both cases:

diff --git a/gdb-xml/cf-core.xml b/gdb-xml/cf-core.xml
index b90af3042c..5b092d26de 100644
--- a/gdb-xml/cf-core.xml
+++ b/gdb-xml/cf-core.xml
@@ -5,7 +5,7 @@
      are permitted in any medium without royalty provided the copyright
      notice and this notice are preserved.  -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.coldfire.core">
+<feature name="org.gnu.gdb.m68k.core">
   <reg name="d0" bitsize="32"/>
   <reg name="d1" bitsize="32"/>
   <reg name="d2" bitsize="32"/>
diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
index 64290d1630..0ef74f7488 100644
--- a/gdb-xml/m68k-fp.xml
+++ b/gdb-xml/m68k-fp.xml
@@ -5,7 +5,7 @@
      are permitted in any medium without royalty provided the copyright
      notice and this notice are preserved.  -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
-<feature name="org.gnu.gdb.coldfire.fp">
+<feature name="org.gnu.gdb.m68k.fp">
   <reg name="fp0" bitsize="96" type="float" group="float"/>
   <reg name="fp1" bitsize="96" type="float" group="float"/>
   <reg name="fp2" bitsize="96" type="float" group="float"/>

As I have not checked the gdb sources for that, I'd like to have your
opinion.

Thanks,
Laurent

