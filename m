Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B074C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529CB20659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529CB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEP4-0000ba-LR
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiENx-0008M7-CL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiENv-00054o-I2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:43:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiENv-00054X-00
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:43:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so26026wmj.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 01:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Izz6eqaHJF82dk24wgCSU7rWS+VPQ9x7Z3J8SM/xK24=;
 b=nZuOLSqcF0VnkNs476Sj0gpEPOU7Oc8l64201KuQsuQaFEiAbKCkvfhwNIuvMenXQo
 M0N690tvCkpR6FFZ2XFNJl3qI0wbM0X72HGT9Mvg2z8XXxXJPXLPwCMuILNt/XMqHP+v
 MniKIQ1Jg3vNhlXsS+u5Kh/x0au0DEbpC4U5wPzugvmAHKK3hWwfhxv+70N073sYlD2j
 wEt8Xi13fyiN8cBcvT/f83iih/UjswgANlWkJi9KR0VRovd5juuERNg4CNFjkDI/SFXn
 RwdDs2SMbqsXivXQ2R6XkwYFyLqn74wlQEOFHTu4tfRNFMjdGTyak4m4T/RfTSfjRVO6
 nvrA==
X-Gm-Message-State: APjAAAUQFtYbmatNQF04MOk9TWW+yKWROHPmIAnPhiOeM0waIC73IexC
 tlcS6M977ur5Nm/iGCqdZ1I8ng==
X-Google-Smtp-Source: APXvYqw4y5OU02W8KuAnZgZ0ghzQvEqAtKErfWJ3y64c4GPfUafhBkWY8b6PlCo6mZrzOQJbF+imDg==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr2521064wmf.162.1562057010062; 
 Tue, 02 Jul 2019 01:43:30 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id s63sm1574448wme.17.2019.07.02.01.43.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 01:43:29 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
References: <20190701164732.30518-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7740d279-d0f7-803b-8d52-660742385313@redhat.com>
Date: Tue, 2 Jul 2019 10:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701164732.30518-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] migration: move port_attr inside
 CONFIG_LINUX
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 6:47 PM, Alex Bennée wrote:
> Otherwise the FreeBSD compiler complains about an unused variable.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  migration/rdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 74cb2aa9f9..3036221ee8 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -839,10 +839,9 @@ static void qemu_rdma_dump_gid(const char *who, struct rdma_cm_id *id)
>   */
>  static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
>  {
> -    struct ibv_port_attr port_attr;
> -
>      /* This bug only exists in linux, to our knowledge. */
>  #ifdef CONFIG_LINUX
> +    struct ibv_port_attr port_attr;
>  
>      /*
>       * Verbs are only NULL if management has bound to '[::]'.
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

