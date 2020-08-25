Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76445C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3646F2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 09:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edEOD3Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3646F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUuY-0007CP-BI
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 05:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAUt1-0005HX-HY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:04:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAUsz-00046z-PS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 05:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598346296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IZcI8b+A4ba3n/6/qslI6wVksqPfMDSd+e6Xax4Pqus=;
 b=edEOD3YewEfqHLW1CnnDwFcv2Ve8QnAyByBP6ek9VB2yI0khH04dvcIeGapv1l3/MMxn9n
 IIZSag8dtps1/upp34EwZOzqgKygWu0y6QMzbb5ZxBFBS/Hp7fE/fg4DGAz9LEPPBfXids
 mb0PtO1eDfZ7tA3+GKVi/CCaqRrYDAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-zkW8sZmgOpWlW-C86pveXQ-1; Tue, 25 Aug 2020 05:04:54 -0400
X-MC-Unique: zkW8sZmgOpWlW-C86pveXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2118189610E;
 Tue, 25 Aug 2020 09:04:53 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB0577C0F3;
 Tue, 25 Aug 2020 09:04:52 +0000 (UTC)
Date: Tue, 25 Aug 2020 10:04:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: luoyonggang@gmail.com
Subject: Re: [PATCH 2/5] meson: fixes relpath may fail on win32. for example
 C:/msys64/mingw64/x.exe relative to E:/path/qemu-build would fail.
Message-ID: <20200825090449.GE107278@redhat.com>
References: <20200825083500.359-1-luoyonggang@gmail.com>
 <20200825083500.359-2-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200825083500.359-2-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Subject line is waaaaay too long here.  The explanation should be
in the commit message body, not the subject.

On Tue, Aug 25, 2020 at 04:34:57PM +0800, luoyonggang@gmail.com wrote:
> From: Yonggang Luo <luoyonggang@gmail.com>
> 
> ---
>  scripts/mtest2make.py | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
> index bdb257bbd9..d7a51bf97e 100644
> --- a/scripts/mtest2make.py
> +++ b/scripts/mtest2make.py
> @@ -53,9 +53,16 @@ i = 0
>  for test in json.load(sys.stdin):
>      env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
>                      for k, v in test['env'].items()))
> -    executable = os.path.relpath(test['cmd'][0])
> +    executable = test['cmd'][0]
> +    try:
> +        executable = os.path.relpath(executable)
> +    except:
> +        pass
>      if test['workdir'] is not None:
> -        test['cmd'][0] = os.path.relpath(test['cmd'][0], test['workdir'])
> +        try:
> +            test['cmd'][0] = os.path.relpath(executable, test['workdir'])
> +        except:
> +            test['cmd'][0] = executable
>      else:
>          test['cmd'][0] = executable
>      cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
> -- 
> 2.27.0.windows.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


