Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E6EC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A712098B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 22:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YCG290Cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A712098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS6VJ-0001l3-OH
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 18:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS6NN-00074D-Lg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS6NM-0000dz-SQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:00:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:51315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jS6NM-0000dc-4y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 18:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587765636;
 bh=ALb8X92qc8L8xvkUqkWS6xOEWZ83rzDT/lfpdtIZTks=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=YCG290CqI4dkVo886kzri4EvXbFw5V3DgY285GJ2J6755p1ul9GFUkR4D8UR1QL3o
 9MRushKzziPoYlOhuJ3Ja+/hZWJzsgwoXi5X8nKa1/qptQxEm2EN07wyRYYMv5BG1d
 uTH+CixEDL6RW4yN0lARhk+tX5roboe+J6DBAqsc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.192]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1jmwe00bJU-00KwQL; Sat, 25
 Apr 2020 00:00:36 +0200
Date: Sat, 25 Apr 2020 00:00:33 +0200
From: Helge Deller <deller@gmx.de>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Subject: [PATCH] linux-user: return target error codes for socket() and prctl()
Message-ID: <20200424220033.GA28140@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:W47QfDyyMPu+GsArWjZ7Kox5al85smWPROl8a4IQmdF7LIyrbDK
 JSKU+iVp4sDVo3HdHQ80EffkWUlUlENtpEnM1/IHqFVCZrCnVP3CGgbma7M6wXQksa7hPFA
 5GzM17SQ+z30bURjWgJayV5IPODl1HitYx46K/c6CZxnOVEpChxpLoOc5VISeqqfdOZBQk/
 lgT4V3ca7ESIA/MfVaazA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tNBLsakPdcU=:ZgXlU/snsgEHceiZ1ZQEUS
 V4F7n6RAQZDEz6MbuwgrDC4VeNWFZVxp7R6BY6y+iGrKQNEUXup4MiS0ysQ/mxNCcZi05ynZu
 EniyMzM1l53fRt97Di+5sO1b1hSD0HIW2oNM797lneUrxxMGR+lrZDxSoppwPpS9BNVlQvGHx
 ulFgrPYIYV6MSIqRBpjg1UREdUome/mcJSKUqdCbgflc3D0+aY0RMnyEt/sQvugVPXsdT8zRv
 G1OQsBewEuCtk4CWH6FvCYKlnUnmmIuVVz3w/5z/dNBAPpOJLwG+6FaXccrY8HOvvSF7GvOYZ
 Hpbuuud51QwUdtYvvkmxlKoZTS+kG1iEJ9vZxncBfDedu3hBx9XBSFzTPlwQ/Nh14sR02XFqv
 DtZ44IK0FHVWYhPvB1jjds0JG3FmhdEB2qw9rgvgrGPDgedLE0VhBgpy3WXKHgeNezc9+MdvG
 8BZHciBcHFbFfFIh3qip/1u2B4MGzkyx2r4gaDltQ1gT3voi88dDNrKKOWWbw+IhN41UZETtO
 WtUpaxTM3jVOnSu13o49br1FVH5dpayl6rPuPYoBaY8qI9uV0q9eEPsCX/Mznmz+KFlE26Oxw
 CM1a79EgP7umLVsncUY/RMz+A10715MjjDw/9CqiDKIG3FRVqiBe9kN6cfVfD72UB1SY6otb6
 iJ/9Zoh5Io5xVxLdqWZmqsQfHF8rsp+/mEzdTwVCfOe5OiG/LuqXaRMKmihCmw13W7NRVZJ+L
 m/fOQbrLH/vcTtlDDBHfjbEFuQgEZqIqRp6un4OUjENUbotccRs1twGuxaGqt7oXRzS8nvKC4
 BgWjQwe6eDxXSgERnTo80yJtP+n4ACJZwaSOLPFJIfRn8GMrTN+ZwrFWqDFjD5m8LLGtnn4Ru
 J0Y4UbC+M3ls7IVEoB7kePDN0QP04WL09+DbBYbFUUesx04wxjqfQv0WPwVOjDr2mByLJ0QqO
 qjtss9DR/pwzgooqSLTfyRP9bAw9dCKCINtIOXA/51Hs1AV+7K8N4FgwUC4eW01W6V1IYrixR
 VXLvxLFu3X1J69tUvOXbxguOhGzmjPLsz8pmyRxHkRXGmxTneEB4oF+4T4/dMKjMBbYhgGXcX
 mceeZ92tpdrCZpKE/dmBnALQJeufK3dvh+6AZ3z8+R5htqwdZEPPhv10vF7reBV8a4Ek5nirw
 HIpky61SxjHRBbJYF0qlMgokukCPyhrh+Yt80DLkyCh1yF+ajM7Pkwnd07G7xkfRw53exKPX2
 3LmVwCwMocU8n3Qzm
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 18:00:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
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

Return target error codes instead of host error codes.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..655a86fa45 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2987,7 +2987,7 @@ static abi_long do_socket(int domain, int type, int =
protocol)
 #endif
          protocol =3D=3D NETLINK_KOBJECT_UEVENT ||
          protocol =3D=3D NETLINK_AUDIT)) {
-        return -EPFNOSUPPORT;
+        return -TARGET_EPFNOSUPPORT;
     }

     if (domain =3D=3D AF_PACKET ||
@@ -5856,7 +5856,7 @@ static abi_long do_get_thread_area(CPUX86State *env,=
 abi_ulong ptr)

 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 {
-    return -ENOSYS;
+    return -TARGET_ENOSYS;
 }
 #else
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)

