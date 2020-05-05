Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D573C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC4A20757
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Quia9v/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC4A20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVy84-0001gR-3T
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jVy77-00016y-Oy
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:00:01 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:36811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jVy76-0007EQ-00
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:00:01 -0400
Received: by mail-ed1-x532.google.com with SMTP id t12so1933844edw.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:thread-index
 :content-language;
 bh=O9OCBMkBxpYV7nwYvW253+iHNM16Xw+0gCVniK4rZ0A=;
 b=Quia9v/xRYgVnTDwV1BgYeICL+6UIoPhizH6hPPF4DkNcTtvHJl5Ty9UDZWF1Wj0AF
 FS3KgmAq6KlzYeXdYQ3OA++1Q4I0seBrL8agnF3UoSJLLSKmOeC9DQqvrhlT51K/e1v3
 xgF6OTVucZjrirHv5xQwRe0P3H9l5KoUo+hkDyXcUw1NGQ9dQeGxOR/N8raXLcTN0s5g
 wPBq8vTmzTMQayESPKqeEdcHb8eiqjxUByqyltjrifpPut7NUtSbThKGFcm/cKMcc+tQ
 RrGmgDnKGOp8PJc1PEzW2mY7Ht46+7iAqPL4RGQCqPpT46h6N8Zf18TpGw7OoG96GT/c
 phFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :thread-index:content-language;
 bh=O9OCBMkBxpYV7nwYvW253+iHNM16Xw+0gCVniK4rZ0A=;
 b=GRZKpOLVl4ZAdHi6hpaz6mzhmnU/s74cw+gU4cJpNPlEA6JCQQr0YYuxPeUxh7dHZQ
 iqBBs9ZsGmCdah2qbNr4aye40KVGePzIJTHzeZBWaEOTlHnoiVXDNRvb5HjUEfJ6bqoj
 ucEONLgNDALG4rUxDGq+tGB1PpRezlKsbmCyQF2gHenehMKdcY4r+5bYF/xN6w4unVKF
 MeKQ3BDVCiIQtJ/x2JMpei8GL8CCcdQLuXN2xz/PntNC5to/lEZxkfL27JoctvkTWinX
 rFB8K2Gsmdw1qJmQV13riCGeDRkIQZN1Z1jK9WRCIyKvf4KCn2MNG7LG691p2sTlGF5x
 Tl5w==
X-Gm-Message-State: AGi0PuZnxl0hW7n/Xgr9dQNZeKeLCXAclGefPU6UZ7rT/lRi067Isibs
 1nbod2gb1uec8viOnVf6ric=
X-Google-Smtp-Source: APiQypKMaCbhuhWKhU6qOX1gyF4ylKwmgItCJ0Vgnfw2kOhlHOT2eRuqxGQbmSbMf9zCagFUVC55Eg==
X-Received: by 2002:aa7:c0d2:: with SMTP id j18mr2756750edp.283.1588687198204; 
 Tue, 05 May 2020 06:59:58 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.187])
 by smtp.gmail.com with ESMTPSA id n7sm280474edt.69.2020.05.05.06.59.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2020 06:59:57 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Markus Armbruster'" <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
References: <20200505101908.6207-1-armbru@redhat.com>
 <20200505101908.6207-3-armbru@redhat.com>
In-Reply-To: <20200505101908.6207-3-armbru@redhat.com>
Subject: RE: [PATCH v2 02/10] xen: Fix and improve handling of device_add
 usb-host errors
Date: Tue, 5 May 2020 14:59:56 +0100
Message-ID: <004001d622e5$75fd2d70$61f78850$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD2kCtjJmTvNkmzRgy8FtMMvttLfQNDV1uLqj6PYxA=
Content-Language: en-gb
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=xadimgnik@gmail.com; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: paul@xen.org
Cc: 'Anthony Perard' <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Gerd Hoffmann' <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: 05 May 2020 11:19
> To: qemu-devel@nongnu.org
> Cc: Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>; Paul
> Durrant <paul@xen.org>; Gerd Hoffmann <kraxel@redhat.com>; xen-devel@lists.xenproject.org
> Subject: [PATCH v2 02/10] xen: Fix and improve handling of device_add usb-host errors
> 
> usbback_portid_add() leaks the error when qdev_device_add() fails.
> Fix that.  While there, use the error to improve the error message.
> 
> The qemu_opts_from_qdict() similarly leaks on failure.  But any
> failure there is a programming error.  Pass &error_abort.
> 
> Fixes: 816ac92ef769f9ffc534e49a1bb6177bddce7aa2
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Paul Durrant <paul@xen.org>


