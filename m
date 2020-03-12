Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D1C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008C4206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008C4206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRvz-0005bK-Ty
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCRus-0005B9-4q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCRur-0000A1-0o
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:46:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jCRuq-00009C-O7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:46:40 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MmlfM-1jdUza24JC-00jsBd; Thu, 12 Mar 2020 18:46:36 +0100
Subject: Re: [PATCH v3] python/qemu/qmp.py: QMP debug with VM label
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <158403298984.16773.4037733094057966809@39012742ff91>
 <1a934fc6-5461-2391-29cc-44ad105ac646@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ba20f2b0-ace2-8fc4-cdf9-978c3198a009@vivier.eu>
Date: Thu, 12 Mar 2020 18:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1a934fc6-5461-2391-29cc-44ad105ac646@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7joZGaORY7ceFRee43LSgjyGtkTK/7Xsl3fKnXsMxwqEiJ3WJu8
 Q0IEc0ONU3Gd5CdJUUIWN5SsXM7+TIj8yI0CiNZClFp7xdjSuvdfGgt0zkULViwIcGs+tIA
 iCaaENJrY14R6/E4j+aGLE7ZOLR/rzvxAoKSvuuvOr4GdKk7n8ppuEiNdJDBIXFu+fmilq5
 zs2rMO1zF4PiPMxE3CdNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s2+yK0fvHkM=:CNJz3K5ntEtST3SaYFCBIP
 BfAPCPzUCs+syboU/wq7MP2WIPOHzFvc7wVzOyinwcFyBMbdPFrbWnaMJi7BFXJDV6xDSYyhR
 PBKNGScyvJkjO7fPMiyOvSF48oejRHNK1b8XbrpfFolwvKalWT5yn73qrqIB2GpKFFLsJilh5
 QvUFgaJWgwcxWDU0k0I1qP8xFKhZVVlh4TWtJ5kEPR8CpFalJrvizgXVMJi30SIY/DaIuHeqO
 VxK+qALxHtMi4acGhGDk0RsBlGKqA3+S49vogRPYlP6y5pfenDaGV4qVixgOfrCIo3d0eWit7
 xeIejbcvxSWKFdpyNxy+XMkmuO487g1lZYdcjSq+NGOWztnbITRKVzJ0eFISdHY+dHzdKIabX
 9+KE14Xz5mygbHxbmdDPuHuS7HLlUDfrBAlBwN3DGefnvVSfNC7majuhlctWJlbLCfTFIStt4
 HG5gXvSIff1oACwyLRxBRuKnzzkiwLTo8kMVigwEFT+snBNFRlHJqJnen/4Eo8MpBgXDsHCS9
 soYjC9B7iyEFtLTVZdv9bkT8lO4AB4l8LIz9jf+xb0Z/kkf7w/CAaeETTmgQ/o7/t/3/s403z
 2+Sl7iMcjPbpUa7noNFKUdDi5iThDRCAKU3FYsJMwIavpGO4PMNPekwcvbF0f1Bp06IRA6IHN
 1TaOoTxJQ/T0Kn2midzwMAF2b2lj3RT7xUDDZinfTkYFbEH+VHADkpsMMji1kL3Oy/64UjAq/
 GDl0xUEWo4IAdM1NtGs9UaIC5r2EjWaShfBv4VqMjg2GdmGiiTZs7CQspw7W1BQ8+gsQKm00M
 yrvKC0BsQ85G6KBq3HYLMWRkdIeiuZSq/7ke/gSwl95MtjHzF+NhalUSszgb8ZI6V0vp8KG
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/03/2020 à 18:41, John Snow a écrit :
> 
> 
> On 3/12/20 1:09 PM, no-reply@patchew.org wrote:
>> **
>> ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connection: assertion failed (err == NULL): The connection is closed (g-io-error-quark, 18)
>> cleaning up pid 8252
>> make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86_64] Error 1
>> make: *** Waiting for unfinished jobs....
>> Traceback (most recent call last):
>>   File "./tests/docker/docker.py", line 664, in <module>
>> ---
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=a511075ffeef4e779edd675709230bf4', '-u', '1003', '--security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=x86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=', '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-oeozmxxt/src/docker-src.2020-03-12-12.42.08.19167:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-debug']' returned non-zero exit status 2.
>> filter=--filter=label=com.qemu.instance.uuid=a511075ffeef4e779edd675709230bf4
>> make[1]: *** [docker-run] Error 1
>> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-oeozmxxt/src'
>> make: *** [docker-run-test-debug@fedora] Error 2
>>
>> real    27m40.529s
>> user    0m9.189s
> 
> Appears unrelated?
> 
> 

Right.

Peter has committed a fix to disable dbus-vmstate-test

d46f81cb746d tests: Disable dbus-vmstate-test

Thanks,
Laurent

