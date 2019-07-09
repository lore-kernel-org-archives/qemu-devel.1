Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBDDC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB38820861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB38820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hknle-0007It-V9
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36675)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hknks-0006rd-0S
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hknkr-0006rJ-2e
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:53:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hknkq-0006q7-SE
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:53:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so2704259wmj.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 03:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4UMTO+u7gq8TDdGhuQ+iqm4+R1s12+ZLmJeXoQVU0pE=;
 b=U57Mtt2GHBuKWQBu1ZadErCkYniLeRA+IZUWBeWnaOE1w+fJTILjh3O5IB0dcKoDWy
 j+uE6izpAhLBo8HyHduzlfpcC81CgaFNzswgHuJlucdO327aFH8Br1Dse9MugtZfngBF
 PbvC5+3xAKgPZ1sGEkXJ1C/0m/Jx4wch45avyEcWEY057ocI/XvH1Yfa3Lf8C4w+DPLw
 FM/efaYi0/tURP1lDInMatYpU99YxmxowT4BlumM8zQ/I/7a7ELDG0vn+CYEhUBn/s6A
 RI7Wu9C1VCoKo54fnqpbK2xe5YDW0fRCLQwY6FGivHR7l4C6Emcm73DgJaoxulNB2MGb
 /3kQ==
X-Gm-Message-State: APjAAAUgex/O+paawepVCZ5n+i1e0HLyUSdD2LQkeAcvVJwKGNuf7QRL
 5FRbwxcZmRk0+XkdSsyKxMAyUg==
X-Google-Smtp-Source: APXvYqyiVl9pSx16dTQyPhMeZ4LWBcqD08GA9gR/rtHf7fsqMa4TkDS/ku7HlILXNXSosF4vGIZVzA==
X-Received: by 2002:a05:600c:21d4:: with SMTP id
 x20mr716161wmj.61.1562669626873; 
 Tue, 09 Jul 2019 03:53:46 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id 5sm2260289wmg.42.2019.07.09.03.53.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 03:53:46 -0700 (PDT)
To: Julio Montes <julio.montes@intel.com>, qemu-devel@nongnu.org
References: <20190708211936.8037-1-julio.montes@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1eb3f75e-01b0-990b-44c2-1770982da5b5@redhat.com>
Date: Tue, 9 Jul 2019 12:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708211936.8037-1-julio.montes@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC] memory-backend-file/nvdimm: support
 read-only files as memory-backends
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
Cc: pbonzini@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Igor & Xiao.

On 7/8/19 11:19 PM, Julio Montes wrote:
> Currently is not possible to use a file that is part of a read-only
> filesystem as memory backend for nvdimm devices, even if this is not modified
> in the guest. In order to improve the security of Virtual Machines that share
> and do not modify the memory-backend-file, QEMU should support
> read-only memory-backeds.
> 
> Use case:
> * Kata Containers use a memory-backed-file as read-only rootfs, and this
>   file is used to start all the virtual machines in the node.
>   It would be really bad if somehow a malicious container modified it.
> 
> Signed-off-by: Julio Montes <julio.montes@intel.com>
> ---
>  exec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index 50ea9c5aaa..1eb170b55a 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1852,6 +1852,12 @@ static int file_ram_open(const char *path,
>                  break;
>              }
>              g_free(filename);
> +        } else if (errno == EROFS) {
> +            fd = open(path, O_RDONLY);

While I can understand your use case, I'm not sure we want this silenced
as default. I'd expect an explicit command line option for that backend,
but I don't know well this area so let's wait for other to review.

> +            if (fd >= 0) {
> +                /* @path names an existing read-only file, use it */
> +                break;
> +            }
>          }
>          if (errno != EEXIST && errno != EINTR) {
>              error_setg_errno(errp, errno,
> --
> 2.17.2
> 

