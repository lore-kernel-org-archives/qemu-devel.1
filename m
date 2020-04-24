Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB94C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA44520781
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 21:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VN1nTHMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA44520781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS5cs-0000QU-NV
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 17:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS5V9-0006r7-9Y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS5Uu-0002xP-5X
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:04:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:50179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jS5Ut-0002ud-Jb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 17:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587762263;
 bh=3rs3X4Ir6G+PDtHXU0JI9XQJTg3I84lLoA6Z50WgLz8=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=VN1nTHMUrsyyYMOehDKYOycQjtYuV0KxsYGZKEaSBe3eo+ZOsQKF9mJd1wUWzqW7S
 Ryt9aHG+eip9TgGXvT+Wx3fuWl7LvRUqb6fxIcbnYPLEIv3yazvrcgEDiz3TeKOURg
 wyTkaKIkharl25LcLRa+AR/WzfaUjthWwC7OY6qo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.192]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6bfq-1j8vov2pTy-0185bp; Fri, 24
 Apr 2020 23:04:23 +0200
Date: Fri, 24 Apr 2020 23:04:22 +0200
From: Helge Deller <deller@gmx.de>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Drop unnecessary check in signalfd4 syscall
Message-ID: <20200424210422.GB26282@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:15ZIqvKIg3XIgFP/CbI9vHxcyKpVGGeF6FlNylICx3R7+Hz5OQ4
 imEF5OEbizyeyYHVyKFUsaVxeRoSBOH0HlTKJd0K5arF5klR4xtC4UvYe8AiHyq4rLUUlI6
 eCg7+FHMCvq/LOwgmm6TUu6e9rRUgvMx7nxKiq+yBp3lw8bQQ5c7Y6sXjKvOr1PVP7o4ry7
 XVKH6ZNMzPoxVQ5O5UQHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3titibExSQo=:FfLBx+nJKjwC/j9Il6I10R
 rFGQmqYaugt3INW9bwEfv0J42G6llq5DUgETCnY+DQWBNq28Rn6a7Ee7UbD6M6iyduNHXvJBq
 NGSVxVPekp97K09Sr9ijn8YPRfNiN8HBxqwyscDX3fx4iEKigEST2MVn1U4yHJLy3a+VnJhGv
 rfQCtJbJJyaHz/Cnb0hJdoVQfWLCT6XHyVS/iTKYf2mc55OESuc/OJG4t2uzU7m33W+KZvK+x
 gtcYGHaXPPS2l2UP8KL2d7IuvgkyLrR7fL4q3iQmOXHJiJLyKQLH1IiNjNA5Nl7EUQ0yohbwh
 2HLbrYKbUXn0UfdnNerN9V6GFMnQYKpCpxpCGgHmbmeWWuruFkJXdhOvEuT6psRhGHSdwq+rV
 11xrQj7+yHJc6NWzEvFPPHOG2hB9VgfMOR6Iirlz61uA6UDqR4Akfd8NZQGK0KmfEuhV3ov5M
 crXGKsU3dA8Bu2dqC0rYFYVFNfJwIDKNxqPKa+uEmiNaZ1IPsmnjz7zwSVIV0EduDv0esgWd4
 8DF7mdvgNweAGe/vKa/e6T6duzQNevZdS+78ZdPjWZ/ktjmv/Adqs7UJFXibE5NuBrEatM4ya
 j+ypjlH3uOHnXxs7RabPeURTxl0BikLtgt9zmkQ4Ji82gttcU7XnR8jXXYKmlrAqBA9Qch9hL
 /dv+r1S4nky/F+vBRUs+mBuR3VWpGhKdyaKC1bGwu3tky2MaoA6TkYxbIyWupJe2czhi8b2VX
 ZCezlc5wHhsgRxJZxQXB9VlHwardke6vG/xQ/dg6kgtu7Bn8DNVYGW1PBXcOrWjnY5i5vQlTV
 EROvimGvEfNz7Jg7d3mNvujz/qBivDGDfs8B4zQz9P43Jo/Bcc7slwt6yDMQklSsP7swBFir6
 pVJ+xInTEhhXVAixm8wjJd5B4MI9GjzmWxr7xMW05uqmnX+3AvuQ3nIEh6o8bRIeEqUkkVDyC
 RP1TihSbW6HASKm1kBOcvDeNNh7FchmKRVCs83jpOj8UNpenIJOF7NwMjefKkfnvuG/tmkBVL
 mElBglE5rO0GQhDlPTzPS4gUR933mBsfeoX6xhW2gS3wR1IAG3LAD0WHCXqrKH8lBwdwQLnPE
 PUiKEHIfBMQ+PGIN9/8rNfLojhpefqZ6GzntUUTO/oAE3+aw2NfNcc/3wfBIN+JvPvGOA2kPV
 KSfWHXKiGDEb+/IOMM3kA3IZ++Hgi/mJ5K9qqZBLUzBKQDmcMgORDAx95ReBioF5eDO8anr8X
 Nrzd735+2i3h5CFYB
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 17:04:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.17.20
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

The signalfd4() syscall takes optional O_NONBLOCK and O_CLOEXEC fcntl
flags.  If the user gave any other invalid flags, the host syscall will
return correct error codes, so simply drop the extra check here.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..ebf0d38321 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7176,9 +7176,6 @@ static abi_long do_signalfd4(int fd, abi_long mask, =
int flags)
     sigset_t host_mask;
     abi_long ret;

-    if (flags & ~(TARGET_O_NONBLOCK | TARGET_O_CLOEXEC)) {
-        return -TARGET_EINVAL;
-    }
     if (!lock_user_struct(VERIFY_READ, target_mask, mask, 1)) {
         return -TARGET_EFAULT;
     }

