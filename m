Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD0CC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0751C217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0751C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH9Dd-0007Ak-8N
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:44:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH94O-0007d7-CD
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hH8wC-0002DT-Ud
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:26:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hH8wC-0002D4-KI
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:26:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so3376909wmd.0
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 08:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Pa7lLHFNbGvoBlO0A9+FQCbG6c6HG0V1VPl1vzBfrrc=;
	b=S5UadXhHUmnsUJsSKWxTaFXpgMYlbcnj8XxYSO8LkLm5txH7eGQqnPLIZ3q2QE+Sv8
	KG9ZLJWYU48D5iJreEXlL/8slSS8vjoeNXU0fr9z5xPLw+rOsSMnb42aRCFhzcsWFdBT
	5+qNDME1HmdzV9sa09htVC17Kwn6JyP4FcT0Kt/EVcGUvIHpWoyR4LxPljOB63i/DmxU
	/hS3Pyj72yaDG8fjdLHpx5Qn9RgAW0r3GBvzaaPpD8l1OojVrxQKz7fsgjF+Wr4RA/mQ
	SX8uO16hFeYNno4QW1Z4CoV6luX8DRQnzBMMYyvQkcUkAXlgvSgR3k1U+0LzwNnb2RWQ
	CJrw==
X-Gm-Message-State: APjAAAXCp1h/7UipjGmR0YXHvbenn8GJfqMxEeiYcJvppDEEHIh47iQs
	s4+ahFc26fYdlYixBU2/4ckMD8xDkuI=
X-Google-Smtp-Source: APXvYqxF7xNG9SfFA2KtLuZUc0pxZNtoF3ZfLAmD31O8X0p2dOvjbJ/vSODWOBCP6CheygdxkOhyNQ==
X-Received: by 2002:a1c:4102:: with SMTP id o2mr3392762wma.91.1555601215198;
	Thu, 18 Apr 2019 08:26:55 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id z7sm2868486wrt.10.2019.04.18.08.26.54
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 18 Apr 2019 08:26:54 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <78da03ed-2b9f-2357-6f28-44115d8b2955@redhat.com>
Date: Thu, 18 Apr 2019 17:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418145355.21100-4-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 3/6] gdbstub: Reject invalid RLE repeat
 counts
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418152654.slACDWFVeBgw5zo7vSWhdngPYD1_hLtNKraK1WExE0o@z>

On 4/18/19 4:53 PM, Markus Armbruster wrote:
> "Debugging with GDB / Appendix E GDB Remote Serial Protocol /
> Overview" specifies "The printable characters '#' and '$' or with a
> numeric value greater than 126 must not be used."  gdb_read_byte()
> only rejects values < 32.  This is wrong.  Impact depends on the caller:
> 
> * gdb_handlesig() passes a char.  Incorrectly accepts '#', '$' and
>   '\127'.
> 
> * gdb_chr_receive() passes an uint8_t.  Additionally accepts
>   characters with the most-significant bit set.
> 
> Correct the validity check to match the specification.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub.c b/gdbstub.c
> index d54abd17cc..a6dce1b027 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2064,7 +2064,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>              }
>              break;
>          case RS_GETLINE_RLE:
> -            if (ch < ' ') {

Can you add a comment referring to the ""Debugging with GDB / Appendix E
GDB Remote Serial Protocol / Overview" here?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +            if (ch < ' ' || ch == '#' || ch == '$' || ch > 126) {
>                  /* invalid RLE count encoding */
>                  trace_gdbstub_err_invalid_repeat((uint8_t)ch);
>                  s->state = RS_GETLINE;
> 

