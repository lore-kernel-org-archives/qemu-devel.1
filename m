Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D35CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1554720869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT3vhVd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1554720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgEW-00054G-7T
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1iRgBT-0002We-6y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1iRgBS-0006JW-11
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:30:31 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>)
 id 1iRgBR-0006JI-Se; Mon, 04 Nov 2019 12:30:29 -0500
Received: by mail-ot1-x341.google.com with SMTP id v24so9820779otp.5;
 Mon, 04 Nov 2019 09:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G7LqUjdUFS8Ng+Jk2kahdGoWRlXL6jymTZhgH4Ewo6Q=;
 b=iT3vhVd6/M9LDBkNhmTHA4oLKT5ndYc/rNBeaWAOvu8Y/RKhdmn+syy3NZOQuH74ej
 9FUbvIrcM0EnBBFb8TR7Yrt+NbhzSXwwDaPUq8YIkJBNXMli/rWt6TBcW0XYqBP8tkzX
 bURwaPCTIuYmcnHp7NEcuGdosKr+ZpwtytRO6WhYv1BuAoj/KROkYV5QEDXcytpW+od8
 920f2vbWtg9DLNwyj9X2IQFU/8zSbkIpW6n09LMKH2kkK59uZWwVorZziMpH+yN5DQUl
 L9tKurV8DeeSuvWJj6Po+xQOl7AOH99g5gzCNqKDYo7BVGuA4hvOTDt42d6YQQiwZuUU
 0McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=G7LqUjdUFS8Ng+Jk2kahdGoWRlXL6jymTZhgH4Ewo6Q=;
 b=YP37nQmBywOSGny+uC8SOR/8m877jD288JQPDbXSLh2J2a3CQ0NLMqTxAae0ASy13n
 fFk1vzHbD1LCINK5Dv6gaVvKzB8rR21Y6JAcRRd0+M1eiGuNjfxVKBmBQkAGZ8ajKB/Y
 wWxisHfp++DQBW0NfFMpfXnoz9VXf5etEY+mcpeKzOWEbUFieOntS7/9LWy6RMX2ZT+f
 i0zEgGY543ljCnS9v6jY1twp0p7wWazB+/gGA5zH2E9CBpx06OsMBJbcWmoHfE26Ao/b
 ed3U1a9djrCuic2nWOTDgOajSvi2ky7RX4K0ekdty8kfBrBq6b44vIQf7fuxEgm51mzR
 uJnA==
X-Gm-Message-State: APjAAAVUD6uA74I5AzkgkhR+YJrsi0E8Ehpm/BBZ9H1+jiPW8Ily5MuF
 wupOgXVwY4KWsAdwrz0W4oSX9slAGNg=
X-Google-Smtp-Source: APXvYqxI/WKuAR8AXRVWL3X2mmn0WuPmjZXs0qCA0bXcKlagFkLFNmpZ8DoaN8Pmp5Tw1mpwKc6Itg==
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr2483732otq.270.1572888628305; 
 Mon, 04 Nov 2019 09:30:28 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 64sm614386otv.9.2019.11.04.09.30.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 Nov 2019 09:30:27 -0800 (PST)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] qga-win: network-get-interfaces command name field bug fix
Date: Mon,  4 Nov 2019 11:30:16 -0600
Message-Id: <20191104173017.14324-2-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104173017.14324-1-mdroth@linux.vnet.ibm.com>
References: <20191104173017.14324-1-mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Bishara AbuHattoum <bishara@daynix.com>, peter.maydell@linaro.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bishara AbuHattoum <bishara@daynix.com>

Network interface name is fetched as an encoded WCHAR array, (wide
character), then it is decoded using the guest's CP_ACP Windows code
page, which is the default code page as configure in the guest's
Windows, then it is returned as a byte array, (char array).

As stated in the BZ#1733165, when renaming a network interface to a
Chinese name and invoking this command, the returned name field has
the (\ufffd) value for each Chinese character the name had, this
value is an indication that the code page does not have the decoding
information for the given character.

This bug is a result of using the CP_ACP code page for decoding which
is an interchangeable code page, instead CP_UTF8 code page should be
used for decoding the network interface's name.

https://bugzilla.redhat.com/show_bug.cgi?id=1733165

Signed-off-by: Bishara AbuHattoum <bishara@daynix.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6b67f16faf..64b1c754b0 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1387,12 +1387,12 @@ static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
 static char *guest_wctomb_dup(WCHAR *wstr)
 {
     char *str;
-    size_t i;
+    size_t str_size;
 
-    i = wcslen(wstr) + 1;
-    str = g_malloc(i);
-    WideCharToMultiByte(CP_ACP, WC_COMPOSITECHECK,
-                        wstr, -1, str, i, NULL, NULL);
+    str_size = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, NULL, 0, NULL, NULL);
+    /* add 1 to str_size for NULL terminator */
+    str = g_malloc(str_size + 1);
+    WideCharToMultiByte(CP_UTF8, 0, wstr, -1, str, str_size, NULL, NULL);
     return str;
 }
 
-- 
2.17.1


