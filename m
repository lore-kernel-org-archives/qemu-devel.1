Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331C5C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:03:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082EA20665
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 13:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082EA20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho64b-0007BU-38
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 09:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53853)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho64B-0005tg-Go
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho646-0001ey-Jf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:03:23 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:59003)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho646-0001ba-CP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 09:03:18 -0400
Received: from player798.ha.ovh.net (unknown [10.109.146.240])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 8984911039E
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 15:03:15 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id C16178296F3E;
 Thu, 18 Jul 2019 13:03:09 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, Joel Stanley <joel@jms.id.au>
References: <20190718054218.9581-1-joel@jms.id.au>
 <20190718061628.GM8468@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <215c832d-779c-1597-02af-3a3a52e19f01@kaod.org>
Date: Thu, 18 Jul 2019 15:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718061628.GM8468@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7931683370460875584
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.72.44
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: update skiboot to v6.4
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/2019 08:16, David Gibson wrote:
> On Thu, Jul 18, 2019 at 03:12:17PM +0930, Joel Stanley wrote:
>> Currently we fail to boot a qemu powernv machine with a Power9
>> processor:
>>
>>  PLAT: Detected generic platform
>>  PLAT: Detected BMC platform generic
>>  CPU: All 1 processors called in...
>>  CHIPTOD: Unknown TOD type !
>>  CHIPTOD: Failed ChipTOD detection !
>>  Aborting!
>>
>> With v6.4 we can boot both a Power8 and Power9 powernv machine.
>>
>> Built from submodule with powerpc64le-linux-gnu-gcc (Debian 8.3.0-2).
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Applied to ppc-for-4.2, thanks.
> 
> If you could add both POWER8 and POWER9 smoke tests to
> boot-serial-test that would be even better.

There is one for POWER8 and adding an extra for POWER9 results
in a test conflict. So I came up with the patch below. Would that
be OK ?


C.

@@ -104,6 +104,7 @@ static testdef_t tests[] = {
       "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken",
       "Open Firmware" },
     { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
+    { "ppc64", "powernv", "-cpu POWER9", "OPAL" },
     { "ppc64", "sam460ex", "-device e1000", "8086  100e" },
     { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
     { "i386", "pc", "-device sga", "SGABIOS" },
@@ -222,6 +223,17 @@ static void test_machine(const void *dat
     close(ser_fd);
 }
 
+static char* build_testname(testdef_t *t)
+{
+    char suffix[2] = "";
+
+    if (!strcmp(t->machine, "powernv")) {
+        sscanf(t->extra, "-cpu POWER%1s", suffix);
+    }
+
+    return g_strdup_printf("boot-serial/%s%s", t->machine, suffix);
+}
+
 int main(int argc, char *argv[])
 {
     const char *arch = qtest_get_arch();
@@ -231,7 +243,7 @@ int main(int argc, char *argv[])
 
     for (i = 0; tests[i].arch != NULL; i++) {
         if (strcmp(arch, tests[i].arch) == 0) {
-            char *name = g_strdup_printf("boot-serial/%s", tests[i].machine);
+            char *name = build_testname(&tests[i]);
             qtest_add_data_func(name, &tests[i], test_machine);
             g_free(name);
         }

