Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CF8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A2A206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fr3xKh9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A2A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaQs-0007Td-Cn
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1jyaMl-0001vE-Uw
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:30:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49870
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1jyaMk-0003eY-7M
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595507425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbZ6zQHUO/qRnHbVwa1y91z0hfvW9Y/HIYbu9w/ENOI=;
 b=Fr3xKh9i7DqXqat4yv4eF2BfpACOcqpQtk6qtwNhADucfXADdcnc1YQxZar6SmbZcB774u
 bD2vV37defHqxyB1PIOvZPSmJzhRWmm3HMZYGx9+kyFJph6QuMEqrELjmdxvcFjm+fSEDQ
 7zbhI5WpF5AXtJ3N/BlxePeSWz77p+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-v0wOjtGROe6Dm2Hpr-G2WQ-1; Thu, 23 Jul 2020 08:30:19 -0400
X-MC-Unique: v0wOjtGROe6Dm2Hpr-G2WQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ACB88017FB;
 Thu, 23 Jul 2020 12:30:18 +0000 (UTC)
Received: from localhost (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F045C69529;
 Thu, 23 Jul 2020 12:30:05 +0000 (UTC)
Date: Thu, 23 Jul 2020 13:30:04 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 05/13] block/ssh: auto-ify URI parsing variables
Message-ID: <20200723123004.GO3888@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
 <20200709194234.2117650-6-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200709194234.2117650-6-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 11:42:26PM +0400, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  block/ssh.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/block/ssh.c b/block/ssh.c
> index 098dbe03c15..c8f6ad79e3c 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -180,9 +180,9 @@ static void sftp_error_trace(BDRVSSHState *s, const char *op)
>  
>  static int parse_uri(const char *filename, QDict *options, Error **errp)
>  {
> -    URI *uri = NULL;
> -    QueryParams *qp;
> -    char *port_str;
> +    g_autoptr(URI) uri = NULL;
> +    g_autoptr(QueryParams) qp = NULL;
> +    g_autofree char *port_str = NULL;
>      int i;
>  
>      uri = uri_parse(filename);
> @@ -192,23 +192,23 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
>  
>      if (g_strcmp0(uri->scheme, "ssh") != 0) {
>          error_setg(errp, "URI scheme must be 'ssh'");
> -        goto err;
> +        return -EINVAL;
>      }
>  
>      if (!uri->server || strcmp(uri->server, "") == 0) {
>          error_setg(errp, "missing hostname in URI");
> -        goto err;
> +        return -EINVAL;
>      }
>  
>      if (!uri->path || strcmp(uri->path, "") == 0) {
>          error_setg(errp, "missing remote path in URI");
> -        goto err;
> +        return -EINVAL;
>      }
>  
>      qp = query_params_parse(uri->query);
>      if (!qp) {
>          error_setg(errp, "could not parse query parameters");
> -        goto err;
> +        return -EINVAL;
>      }
>  
>      if(uri->user && strcmp(uri->user, "") != 0) {
> @@ -219,7 +219,6 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
>  
>      port_str = g_strdup_printf("%d", uri->port ?: 22);
>      qdict_put_str(options, "server.port", port_str);
> -    g_free(port_str);
>  
>      qdict_put_str(options, "path", uri->path);
>  
> @@ -232,15 +231,7 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
>          }
>      }
>  
> -    query_params_free(qp);
> -    uri_free(uri);
>      return 0;
> -
> - err:
> -    if (uri) {
> -      uri_free(uri);
> -    }
> -    return -EINVAL;
>  }
>  

I had to look up the definition of g_autoptr, and it seems fine
since there's a corresponding URI macro added in the first commit.

ACK

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


