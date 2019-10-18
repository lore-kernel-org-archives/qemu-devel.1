Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9821DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B84C21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B84C21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLT2b-0001UY-Gf
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLT14-0008V9-Sp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLT13-0000eA-8n
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:14:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLT0w-0000c1-BT; Fri, 18 Oct 2019 10:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4760E3082B02;
 Fri, 18 Oct 2019 14:13:57 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4C7E10013A1;
 Fri, 18 Oct 2019 14:13:56 +0000 (UTC)
Subject: Re: [PATCH] qemu-img.texi: Describe data_file and data_file_raw
To: Han Han <hhan@redhat.com>, qemu-devel@nongnu.org,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
References: <20191018095924.4409-1-hhan@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <adf045c3-895c-ccc4-8cf8-1fd2ead496f1@redhat.com>
Date: Fri, 18 Oct 2019 09:13:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018095924.4409-1-hhan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 18 Oct 2019 14:13:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

[cc qemu-block]

On 10/18/19 4:59 AM, Han Han wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1763105
> 
> Signed-off-by: Han Han <hhan@redhat.com>
> ---
>   qemu-img.texi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/qemu-img.texi b/qemu-img.texi
> index b5156d6316..44596c2d93 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -763,6 +763,16 @@ file which is COW and has data blocks already, it couldn't be changed to NOCOW
>   by setting @code{nocow=on}. One can issue @code{lsattr filename} to check if
>   the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
>   
> +@item data_file
> +File name of data file that is stored in the image and used as a default for
> +opening the image. If the option is used, qcow2 file only stores the metadata
> +of the image.
> +
> +@item data_file_raw
> +This option requires @option{data_file}. If this option is set to @code{on},
> +qemu will always keep the external data file consistent as a standalone
> +read-only raw image. Default value is @code{off}.
> +
>   @end table
>   
>   @item Other
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

