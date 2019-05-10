Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E2BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A5D217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 10:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A5D217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40995 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP37j-0002vL-1m
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 06:51:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32J-0007Ge-1e
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hP32I-0003a4-4u
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:55 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hP32H-0003ZS-Sc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 06:45:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MGxYh-1hTjrv2HSt-00E5T6; Fri, 10 May 2019 12:45:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 12:45:34 +0200
Message-Id: <20190510104536.17483-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190510104536.17483-1-laurent@vivier.eu>
References: <20190510104536.17483-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XTBnFtqzqOl1augywSMETV/XokhJfZPtKFteLyMcMV1wCHIzu1r
	mtszKZUX+/G84uveq+tSFMPOKMNBCDu8ypqIPzOZqyJ71rvn1Q59lERCS9kmD6w2Zck7fTf
	TsSupJqbhdLY6tcTJbyBsw+UwEuNjkYThwY/z7oJaXNwx7sVl94XEz2cO7JrFmb6r2DVWVy
	UurXWy785I478K6kgnQUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:glrErueLIBo=:iAXBGMbIdHKDVAVN4EYJK6
	y1hvovHyjlhqRacqF14MMmWlxOBP9z68dPlhIB52fzBdafH6uGIn0q0OXjKI/IJVkbVKE2ifm
	Z8GIEfWHlyNf/kB51g/jdQgB4vkuRqWSRUtB1tbfcHJk/A4jWnlZAFpKm9CkkQp6sY3+StMGD
	gjMIZYbP0nZWeHVkLEQzZtdiP0mzHDfzboj86IaYkEwUXXixiGeM2Xy6gZ/mg6lqzfyXBIGKG
	11hqwCreWGd0Ul342GjpG5cKMUkuHzCc55Z9IA02wnsb5uR5ZnxLK/sO6mDingSSJMqZ2N13c
	kIL3w8X5TmMAJg6kLpo4MA7XJsmuSIwAcX0faw8gbd7QuAwk9NBa4Om/F43jDCyn1Sw6NjPR/
	NRWu8pjl/sYjtxmht1+mgvz0XS0K72u6R3HcYzmqvBRc6vkrdbLmv/fC65HmiBqjkLtbTPa98
	px40B2LxHUEyr/i4ELNJkr2IUT8RmLaGL44p8sMdGmKWMCylK2ah2W5to9viSVchdTql2+vap
	UiwliR+jFIov0GYgfUi35dk11JiBbWoPefembDaIQUBZImJakzMXUM1ahqwsOas7EW3YzRX4a
	fEfBnUJf0yfRqWnBXdSto8IFWMpq+1LtdfNi7lICqxN6zm9JAf6G4eW8JUwV9WFNc46Ei1LB5
	Qe5ufzrCddhGfnMoSpEjnY2/bvv2CXmHfrPH26FUSGHafH9EalCHlgnv26NgCi9Fai4XqUy2u
	gMR+IFi2jUGaPXX70xP/pCmHw300tGdAOl6wIA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 5/7] linux-user: elf: Map empty PT_LOAD
 segments
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Musacchio <thatlemon@gmail.com>

Some PT_LOAD segments may be completely zeroed out and their p_filesize
is zero, in that case the loader should just allocate a page that's at
least p_memsz bytes large (plus eventual alignment padding).

Calling zero_bss does this job for us, all we have to do is make sure we
don't try to mmap a zero-length page.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190503122007.lkjsvztgt4ycovac@debian>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d08fe2346683..ef42e02d8233 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2366,11 +2366,19 @@ static void load_elf_image(const char *image_name, int image_fd,
             vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
             vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
 
-            error = target_mmap(vaddr_ps, vaddr_len,
-                                elf_prot, MAP_PRIVATE | MAP_FIXED,
-                                image_fd, eppnt->p_offset - vaddr_po);
-            if (error == -1) {
-                goto exit_perror;
+            /*
+             * Some segments may be completely empty without any backing file
+             * segment, in that case just let zero_bss allocate an empty buffer
+             * for it.
+             */
+            if (eppnt->p_filesz != 0) {
+                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
+                                    MAP_PRIVATE | MAP_FIXED,
+                                    image_fd, eppnt->p_offset - vaddr_po);
+
+                if (error == -1) {
+                    goto exit_perror;
+                }
             }
 
             vaddr_ef = vaddr + eppnt->p_filesz;
-- 
2.20.1


