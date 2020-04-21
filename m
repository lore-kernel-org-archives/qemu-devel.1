Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF03C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83716206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 14:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83716206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQtam-0002Su-R5
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 10:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQta7-00020Z-1g
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQta6-0006Yq-8u
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:08:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jQta5-0006Vz-KH
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 10:08:57 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MXY2Z-1jjBVP24ER-00Z36V; Tue, 21 Apr 2020 16:08:48 +0200
To: KONRAD Frederic <frederic.konrad@adacore.com>
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
 <429d6d9c-fff7-d64d-3dfb-917d1985ec90@vivier.eu>
 <268c0a26-9ed2-4812-a985-1321e35eb00a@adacore.com>
 <16709c4c-afe1-f6d6-8535-a0717483cc88@vivier.eu>
 <68a84047-113e-bec4-7f25-800b83c5c5d0@adacore.com>
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
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
Message-ID: <ce303ccf-a82e-2580-3e71-19c64a661afe@vivier.eu>
Date: Tue, 21 Apr 2020 16:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <68a84047-113e-bec4-7f25-800b83c5c5d0@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s6FegDzvX1UirMz/LfnnOLAdRpYSEdHBoYL6drWdADKNqjuFcg/
 XLZgh9YT+90kOvZfuYqZ8v0WHjkk/JjoKQILAPTVN81SxNJO2m28JRZVaLZDBHIRcFcrwxb
 XG7UkDVjlHg59PU1AL4gInz2h80iIAZIHWTrpZW9dJTLA9swdgQJLiwJ3qtHZvo5iJH32Cg
 UED3UbQCwd+rzZjdyOYPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fwxz0Hi58Uw=:WoAWzwTXcm3TucwSuKy9EN
 aF+3nxjZCPjOfGwAtn+zJRe3W7ArgamAU2BobKJLa16Sk6VZKlEOAc26HeWtcemtpGDmbRZ9T
 mVuuxx9NY3fTELeKUJlvR7LGmnHNZJuWiGWySTZrf4bJgPGdg7U6+B79bbtLs2NxUGz7jmEO9
 1ZPKe7PsJ8dsCxnEAc+Vfnp/mJdQW6ORFJ6IBKsJe2ea05adZQlW8aT0Kt4ro2GiVUCOPjtJb
 2nwLSh7YmGogQ0baJJ5RsPu25m0Z9m1tPLZbzVu8W7S+qwKv8gZzF1ohcGO4goI2TDCZK5/RN
 m9D8xuDc4StT76A9f5YL1ysRGQJVCgsy0fT6bjSkgqlQ0Vn0JybtUOFtd00g8hIr4k8JqD08J
 Ds/ZNVJZA2tHMCFZwSzFnyPTSd0Pzy0nPJB87li7dgL96KzbH8B82wH1wHwcN/CLSD6Zn/C6M
 m4GnsNqedEeYhU9S+g+RARIqFHyOpu6ndllknYNtJf4ODMsM6pdN9DY7dEKDaxVHyzFwPqG2a
 Fz79kAMEWH1DBg003UxeCiJ5G1E7+pe6IKXOCOENSEYzh6iFBLMX2UJ+kryrBeYbgNtgPB4nN
 ahxS1N986VRyJXGFCPidoQRUzeUa4/oEA0ToaGwh4Kaa27xmSwZvzbjXX6oenGzCGl6aCVwIG
 Ew+Ht+IYPjEKJ4xSNHsTtuA57tl9OoWJp6n20pseW95e16s7HJCoQXKPJWG19KlvPJPQlJoEH
 vMR4CBGB5hnfzIFjA6laJ6i06iOdUfaeZT4Ip0jDT/7xVqM84+jamMQ9tngxZw6kxgw8hl0XU
 CE9N4tcm43e+lQXxQ9LqrJWYlWD7MyKoc98sq7XMfjbD3Vh2GysqnsokyJF/w6+YSv2vCUj
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 10:08:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.126.187
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

Le 21/04/2020 à 11:47, KONRAD Frederic a écrit :
> 
> 
> Le 4/20/20 à 10:43 PM, Laurent Vivier a écrit :
>> Le 20/04/2020 à 21:08, KONRAD Frederic a écrit :
>>>
>>>
>>> Le 4/20/20 à 5:46 PM, Laurent Vivier a écrit :
>>>> Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
>>>>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>>>>
>>>>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.
>>>>> Thing is
>>>>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then
>>>>> expects
>>>>> a coldfire FPU instead of the default m68881 FPU.
>>>>
>>>>
>>>> I checked in gdb sources and there is no cf definition.
>>>>
>>>> Moreover if I change only the cf to m68k in QEMU it seems to work in
>>>> both cases:
>>>>
>>>> diff --git a/gdb-xml/cf-core.xml b/gdb-xml/cf-core.xml
>>>> index b90af3042c..5b092d26de 100644
>>>> --- a/gdb-xml/cf-core.xml
>>>> +++ b/gdb-xml/cf-core.xml
>>>> @@ -5,7 +5,7 @@
>>>>         are permitted in any medium without royalty provided the
>>>> copyright
>>>>         notice and this notice are preserved.  -->
>>>>    <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>>> -<feature name="org.gnu.gdb.coldfire.core">
>>>> +<feature name="org.gnu.gdb.m68k.core">
>>>>      <reg name="d0" bitsize="32"/>
>>>>      <reg name="d1" bitsize="32"/>
>>>>      <reg name="d2" bitsize="32"/>
>>>
>>> Doesn't that break gdb with coldfire?
>>>
>>>> diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
>>>> index 64290d1630..0ef74f7488 100644
>>>> --- a/gdb-xml/m68k-fp.xml
>>>> +++ b/gdb-xml/m68k-fp.xml
>>>> @@ -5,7 +5,7 @@
>>>>         are permitted in any medium without royalty provided the
>>>> copyright
>>>>         notice and this notice are preserved.  -->
>>>>    <!DOCTYPE feature SYSTEM "gdb-target.dtd">
>>>> -<feature name="org.gnu.gdb.coldfire.fp">
>>>> +<feature name="org.gnu.gdb.m68k.fp">
>>>>      <reg name="fp0" bitsize="96" type="float" group="float"/>
>>>>      <reg name="fp1" bitsize="96" type="float" group="float"/>
>>>>      <reg name="fp2" bitsize="96" type="float" group="float"/>
>>>>
>>>> As I have not checked the gdb sources for that, I'd like to have your
>>>> opinion.
>>>
>>> In the GDB 8.3 sources: m68k-tdep.c:1091:
>>>
>>>        feature = tdesc_find_feature (info.target_desc,
>>>                      "org.gnu.gdb.m68k.core");
>>>        if (feature == NULL)
>>>      {
>>>        feature = tdesc_find_feature (info.target_desc,
>>>                      "org.gnu.gdb.coldfire.core");
>>>        if (feature != NULL)
>>>          flavour = m68k_coldfire_flavour;
>>>      }
>>>
>>> Hence the change I suggested.  Little later it has also:
>>>
>>>        feature = tdesc_find_feature (info.target_desc,
>>>                      "org.gnu.gdb.coldfire.fp");
>>>        if (feature != NULL)
>>>      {
>>>        valid_p = 1;
>>>        for (i = M68K_FP0_REGNUM; i <= M68K_FPI_REGNUM; i++)
>>>          valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
>>>                          m68k_register_names[i]);
>>>        if (!valid_p)
>>>          {
>>>            tdesc_data_cleanup (tdesc_data);
>>>            return NULL;
>>>          }
>>>      }
>>>        else
>>>      has_fp = 0;
>>>
>>> Which is why I didn't made the change you suggested about the
>>> m68k-fp.xml but I
>>> just tried with this additional change and it doesn't seem to hurt.
>>
>> Thank you for your analysis, it seems a simpler patch works with
>> coldfire and m68k.
> 
> Hi Laurent,
> 
> Arg sorry I though I said that in an other email but apparently I forgot
> to hit
> the send button.  The issue with this simpler patch is that GDB will not
> set:
> 
>   flavour = m68k_coldfire_flavour
> 
> when we are running coldfire emulation, and that might break the ABI
> within GDB.
> According to the comments there, float are returned within D0 for
> ColdFire and
> not the other one.  That's why I cared to keep them separate ie: send
> the right
> "feature name" for the right cpu we are modelling.

Yes, you are right. I've added some traces in GDB to check the result.
I trace the features pointer, the flavour, etc.

Here what I have with your patch:

coldfire:

org.gnu.gdb.m68k.core (nil)
org.gnu.gdb.coldfire.core 0x10e6bf0
org.gnu.gdb.coldfire.fp 0x1197a70
tdep->fpregs_present 1
dep->flavour m68k_coldfire_flavour
floatformats_ieee_double
set_gdbarch_decr_pc_after_break 2
tdep->float_return 0


m68k:

org.gnu.gdb.m68k.core 0x1c21310
org.gnu.gdb.coldfire.fp 0x1b65d10
tdep->fpregs_present 1
tdep->flavour m68k_no_flavour
floatformats_m68881_ext
tdep->float_return 1

All the values are ok, but I try change "org.gnu.gdb.coldfire.fp" to
"org.gnu.gdb.m68k.fp" in gdb-xml/m68k-fp.xml and I think it breaks
something because tdep->fpregs_present turns to be 0:

m68k:

org.gnu.gdb.m68k.core 0x2796b60
org.gnu.gdb.coldfire.fp (nil)
tdep->fpregs_present 0
tdep->flavour m68k_no_flavour
floatformats_m68881_ext

I also tried my patch and as you said it doesn't set the good
floatformat for coldfire (and not the good value for fpregs_present for
m68k):

coldfire:

org.gnu.gdb.m68k.core 0xbdb320
org.gnu.gdb.coldfire.fp 0xbd38d0
tdep->fpregs_present 1
tdep->flavour m68k_no_flavour
floatformats_m68881_ext
tdep->float_return 1

m68k:

org.gnu.gdb.m68k.core 0x1e2cb60
org.gnu.gdb.coldfire.fp (nil)
tdep->fpregs_present 0
tdep->flavour m68k_no_flavour
floatformats_m68881_ext

Thanks,
Laurent

