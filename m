Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126F5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A52221E2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGca9QL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A52221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJg1-0005ss-WD
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaJf0-0005Az-J5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:21:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaJew-0007nd-ED
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604499668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oGbQhz5oeO/fDS3H5K9to3mCQbm/xwezZXB5Mx1byYs=;
 b=QGca9QL+nEyG9/n06jjlsME1OQ9aRrYg+5FAhifWi2pjYplRNl584QE/J/DMtMOElMNaf9
 emVeMD/Muhhbyj0sxoRc/3XXJUcRtHlQDBpCozonsALgqsehjdy8ltO10to1k9i7hgvC8Z
 Dsg0WrZr9/EEUnHfE8p0i1CvkFfg/5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-JanRb7PXMp2_jmDDqE1rdg-1; Wed, 04 Nov 2020 09:21:07 -0500
X-MC-Unique: JanRb7PXMp2_jmDDqE1rdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F138B18C9F55;
 Wed,  4 Nov 2020 14:21:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BBF37EEC9;
 Wed,  4 Nov 2020 14:21:00 +0000 (UTC)
Subject: Re: [PATCH] Prefer 'on' | 'off' over 'yes' | 'no' for bool options
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104140528.608015-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c9251f48-c535-e618-b826-1ba0503ff6f1@redhat.com>
Date: Wed, 4 Nov 2020 15:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201104140528.608015-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/2020 15.05, Daniel P. Berrangé wrote:
> Update some docs and test cases to use 'on' | 'off' as the preferred
> value for bool options.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/system/vnc-security.rst | 6 +++---
>  include/authz/listfile.h     | 2 +-
>  qemu-options.hx              | 4 ++--
>  tests/qemu-iotests/233       | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/vnc-security.rst b/docs/system/vnc-security.rst
> index b237b07330..e97b42dfdc 100644
> --- a/docs/system/vnc-security.rst
> +++ b/docs/system/vnc-security.rst
> @@ -89,7 +89,7 @@ but with ``verify-peer`` set to ``yes`` instead.
>  .. parsed-literal::
>  
>     |qemu_system| [...OPTIONS...] \
> -     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
> +     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=on \
>       -vnc :1,tls-creds=tls0 -monitor stdio
>  
>  .. _vnc_005fsec_005fcertificate_005fpw:
> @@ -103,7 +103,7 @@ authentication to provide two layers of authentication for clients.
>  .. parsed-literal::
>  
>     |qemu_system| [...OPTIONS...] \
> -     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
> +     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=on \
>       -vnc :1,tls-creds=tls0,password -monitor stdio
>     (qemu) change vnc password
>     Password: ********
> @@ -145,7 +145,7 @@ x509 options:
>  .. parsed-literal::
>  
>     |qemu_system| [...OPTIONS...] \
> -     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes \
> +     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=on \
>       -vnc :1,tls-creds=tls0,sasl -monitor stdio
>  
>  .. _vnc_005fsetup_005fsasl:
> diff --git a/include/authz/listfile.h b/include/authz/listfile.h
> index 0a1e5bddd3..0b7fe72198 100644
> --- a/include/authz/listfile.h
> +++ b/include/authz/listfile.h
> @@ -73,7 +73,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(QAuthZListFile,
>   * The object can be created on the command line using
>   *
>   *   -object authz-list-file,id=authz0,\
> - *           filename=/etc/qemu/myvm-vnc.acl,refresh=yes
> + *           filename=/etc/qemu/myvm-vnc.acl,refresh=on
>   *
>   */
>  struct QAuthZListFile {
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 2c83390504..0bdc07bc47 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5002,7 +5002,7 @@ SRST
>          Note the use of quotes due to the x509 distinguished name
>          containing whitespace, and escaping of ','.
>  
> -    ``-object authz-listfile,id=id,filename=path,refresh=yes|no``
> +    ``-object authz-listfile,id=id,filename=path,refresh=on|off``
>          Create an authorization object that will control access to
>          network services.
>  
> @@ -5047,7 +5047,7 @@ SRST
>  
>               # |qemu_system| \\
>                   ... \\
> -                 -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=yes \\
> +                 -object authz-simple,id=auth0,filename=/etc/qemu/vnc-sasl.acl,refresh=on \\
>                   ...
>  
>      ``-object authz-pam,id=id,service=string``
> diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
> index a5c17c3963..0b99530f7f 100755
> --- a/tests/qemu-iotests/233
> +++ b/tests/qemu-iotests/233
> @@ -83,7 +83,7 @@ echo
>  echo "== check plain client to TLS server fails =="
>  
>  nbd_server_start_tcp_socket \
> -    --object tls-creds-x509,dir=${tls_dir}/server1,endpoint=server,id=tls0,verify-peer=yes \
> +    --object tls-creds-x509,dir=${tls_dir}/server1,endpoint=server,id=tls0,verify-peer=on \
>      --tls-creds tls0 \
>      -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
>  
> @@ -128,7 +128,7 @@ echo "== check TLS with authorization =="
>  nbd_server_stop
>  
>  nbd_server_start_tcp_socket \
> -    --object tls-creds-x509,dir=${tls_dir}/server1,endpoint=server,id=tls0,verify-peer=yes \
> +    --object tls-creds-x509,dir=${tls_dir}/server1,endpoint=server,id=tls0,verify-peer=on \
>      --object "authz-simple,id=authz0,identity=CN=localhost,, \
>        O=Cthulu Dark Lord Enterprises client1,,L=R'lyeh,,C=South Pacific" \
>      --tls-authz authz0 \
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


