Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE27C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 12:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4FE206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 12:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4FE206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfMmm-0002Ip-5s
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 08:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jfMmA-0001ps-Im
 for qemu-devel@nongnu.org; Sun, 31 May 2020 08:09:14 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jfMm9-0003Rx-CL
 for qemu-devel@nongnu.org; Sun, 31 May 2020 08:09:14 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MgNQd-1j44ks3Z8x-00hyuJ; Sun, 31 May 2020 14:09:10 +0200
Subject: Re: [PATCH] target/m68k: implement fmove.l #<data>,FPCR
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20200531110231.620711-1-laurent@vivier.eu>
 <96042cba-c58b-576e-b34e-e30a817234e3@physik.fu-berlin.de>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc5566c3-b103-aa28-db51-cabf5742c5aa@vivier.eu>
Date: Sun, 31 May 2020 14:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <96042cba-c58b-576e-b34e-e30a817234e3@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f3p51JcrjhcAXC3/GLFSGr6q8dybQFJeWY0OOvr8NUyAbZKnYgN
 9tHGcNodPqwtutiMGLqN9xb8bl/SbqoJaJxao/4/FztDqi2WHtk2MhiadwoBH9dVz/6FZP7
 3iwBYHXiHtmfg4MxDkmoaDGsA/FRnLO4sBPGOMlIB6ZjFasNtKw+N/F4rmNX44pW4TZMdZ6
 ekoUy5lF9uoG4QcKMEf4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6m2lhQzbXRo=:MNVH8bUFnHyzxAeYD4jwR4
 KkEX4nJczIwEcq2WwTzoeBMeXatmQq4eshSscD5PCnH/RZkR2olvJ2dtuLDDb32wNAUhRqxId
 dVbkejshd8yUUsezmiv2g6yTcqm0CyOlR/K14iuMPxcBnPyzz5WoB78aoFkRV0Axy3GscYLWC
 6eIezIsUI1BVO3atgaSCbfAXD9E2sD836X1lPwCDgikY6YrwwF2VtEo1bG50ftlif5KpPNzph
 ckowOpNMSW0fPhvy/SLYtSh6geQcVsGLCKSrpilJyhEZDEC4xumkvHTJjVdVOHzi++vjgN+f0
 UvVIrd2YdkWAEwom7xz0h5nxbgfvWCx7DICUVitTDaaR1nwXIcXg/kr3xGW4srnibWgd+SKKt
 q3QstLi/GVJkwwoKR5CoIVReqcYjdIoimUcdLJZPKUUqCDnspM5fe6iwzrv/IF/E0SBnZanTf
 U8RLeiQHshWjXw8LSal7AOMa2GY7cEblgv0GNSBy1kENyKowkfgD1f2Meim3n4PtmBcMcc/WI
 YXrhqO4gpW/fHiAJN+JMVmzmt9akCB/M06JyU4opPOTKdkNtxEhRsTCMzy5AVyJ88WEdjXW+x
 sZYHbiyDlICOnFoD/2sn1RUa9i1K21WMChj01XF7cKnS31xlu/q7kvmezkwmudc57EhvAZf70
 GCwsYErJe39ky/sb3gTSn33u/v32D73jkvZO6ACwD4smEtQZG4UiGOHQ/hwJj5hORCABh7eJ9
 DY9X3uTq7lm2p6YGSKXYCXZxuiC1vjuR2FnW2sNnPFs25vZGTMAnmCASEl/vdw5/S4xYP1WIB
 X5W7O8cwJZ+7cuoN4WoAQ5BwLSEqad3jKqQtq3cVH+S2X4oV4HFkOhgeALYKRpJAS7bLzvi
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 08:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 31/05/2020 à 13:23, John Paul Adrian Glaubitz a écrit :
> Hi Laurent!
> 
> On 5/31/20 1:02 PM, Laurent Vivier wrote:
>> The immediate value mode was ignored and instruction execution
>> ends to an invalid access mode.
>>
>> This was found running 'R' that set FPSR to 0 at startup with
>> a 'fmove.l #0,FPSR' in qemu-system-m68k emulation and triggers a
>> kernel crash:
>> (...)
>> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  target/m68k/translate.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
> Thanks for the fix.
> 
> I applied the patch, but I'm getting a lock-up now as you previously reported
> in the other discussion on the Linux/m68k mailing list:
> 
> root@pacman:~# R
> [   68.420000] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [R:650]
> [   68.420000] Modules linked in: sg evdev mac_hid ip_tables x_tables sha1_generic hmac ipv6 nf_defrag_ipv6 autofs4 ext4 crc16 mbcache jbd2 crc32c_generic sd_mod t10_pi crc_t10dif sr_mod cdrom crct10dif_generic crct10dif_common mac_esp macsonic esp_scsi
> [   68.420000] Format 00  Vector: 0064  PC: 0002df9c  Status: 2008    Not tainted
> [   68.420000] ORIG_D0: ffffffff  D0: 00000000  A2: c02e239a  A1: ffa10000
> [   68.420000] A0: 3c9adf29  D5: 0000000d  D4: 8002ce30
> [   68.420000] D3: 8002b418  D2: 8002b4b4  D1: 00000000
> 
> Is this related or a different bug?
> 
> I have not seen these lockups on real hardware.
I guess you are using my q800-dev branch?

In this branch, there is an attempt to manage unnormalized numbers that
seems to trigger this lock up.

You can either use master + this patch or update your q800-dev branch
from my repo.

Thanks,
Laurent

