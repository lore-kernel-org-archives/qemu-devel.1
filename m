Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3CDC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B352206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fl1GMi+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B352206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwej-0000vd-Cf
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwZX-0005me-Kl
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwZN-0007F7-UH
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600359336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=whKUzThs0csxZPNrQen/HPExnkGE5sVOjQqUGE0+2UU=;
 b=Fl1GMi+U/1CYPPgAMajxAJCvl8cAJWUpAHY/DEhIjSrexaQ1J/bVXRrbyY0uium448sVX7
 eOfGNmjvL7AgCy1rTxQcmerSFW2omGcEqJRwOxyedKXgAEQV8xLfdgY2L6DBsv3NzCxPHw
 R0oJOCj7naBDKE2q9KJo53dV1bg6oNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-Jfw43iEdO0OCnUXXM8Vinw-1; Thu, 17 Sep 2020 12:15:31 -0400
X-MC-Unique: Jfw43iEdO0OCnUXXM8Vinw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F14910BBED9;
 Thu, 17 Sep 2020 16:15:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A941F19930;
 Thu, 17 Sep 2020 16:15:22 +0000 (UTC)
Subject: Re: [PATCH] docs: simplify and clarify the platform support rules
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200917155606.1623795-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6a3673d-8767-ba44-7357-1297ff5c6f83@redhat.com>
Date: Thu, 17 Sep 2020 18:15:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200917155606.1623795-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 17.56, Daniel P. Berrangé wrote:
> The distinction between short life and long life Linux distributions
> turned out to be redundant. They can both be covered in a simple way
> by noting support will target the current release, and the previous
> release for a period of two years or until its EOL. This rule can also
> apply to the other UNIX based distros, leaving only Windows needing a
> different set of rules.
> 
> This also clarifies that Debian LTS is out of scope, because the LTS
> support is provided by a separate group from the main Debian maintainer
> team.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> This is a spin off from the Python 3.5 thread
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06358.html
> 
>  docs/system/build-platforms.rst | 59 ++++++++++-----------------------
>  1 file changed, 18 insertions(+), 41 deletions(-)
> 
> diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.rst
> index 9734eba2f1..03d2fd217f 100644
> --- a/docs/system/build-platforms.rst
> +++ b/docs/system/build-platforms.rst
> @@ -29,51 +29,28 @@ The Repology site https://repology.org is a useful resource to identify
>  currently shipped versions of software in various operating systems,
>  though it does not cover all distros listed below.
>  
> -Linux OS
> ---------
> +Linux OS, macOS, FreeBSD, NetBSD, OpenBSD
> +-----------------------------------------
>  
> -For distributions with frequent, short-lifetime releases, the project
> -will aim to support all versions that are not end of life by their
> -respective vendors. For the purposes of identifying supported software
> -versions, the project will look at Fedora, Ubuntu, and openSUSE distros.
> -Other short- lifetime distros will be assumed to ship similar software
> -versions.
> +The project aims to support the most recent major version at all times. Support
> +for the previous major version will be dropped 2 years after the new major

I hope it is clear that for Ubuntu, major version means LTS and not each
and every bi-annual release?

> +version is released or when the vendor itself drops support, whichever comes
> +first. In this context, third-party efforts to extend the lifetime of a distro
> +are not considered, even when they are endorsed by the vendor (eg. Debian LTS).
>  
> -For distributions with long-lifetime releases, the project will aim to
> -support the most recent major version at all times. Support for the
> -previous major version will be dropped 2 years after the new major
> -version is released, or when it reaches "end of life". For the purposes
> -of identifying supported software versions, the project will look at
> -RHEL, Debian, Ubuntu LTS, and SLES distros. Other long-lifetime distros
> -will be assumed to ship similar software versions.
> +For the purposes of identifying supported software versions available on Linux,
> +the project will look at CentOS, Debian, Fedora, openSUSE, RHEL, SLES and
> +Ubuntu LTS. Other distros will be assumed to ship similar software versions.

Ok, here you explicitly state Ubuntu LTS, so I think it should be clear.

> -Windows
> --------
> -
> -The project supports building with current versions of the MinGW
> -toolchain, hosted on Linux.
> -
> -macOS
> ------
> -
> -The project supports building with the two most recent versions of
> -macOS, with the current Homebrew package set available.
> +For FreeBSD, decisions will be made based on the contents of the ports tree;
> +for macOS, `HomeBrew`_ will be used, although `MacPorts`_ is expected to carry
> +similar versions.
>  
> -FreeBSD
> +Windows
>  -------
>  
> -The project aims to support all versions which are not end of
> -life.
> -
> -NetBSD
> -------
> -
> -The project aims to support the most recent major version at all times.
> -Support for the previous major version will be dropped 2 years after the
> -new major version is released.
> -
> -OpenBSD
> --------
> +The project supports building with current versions of the MinGW toolchain,
> +hosted on Linux (Debian/Fedora).
>  
> -The project aims to support all versions which are not end of
> -life.
> +The version of the Windows API that's currently targeted is Vista / Server
> +2008.
> 

Sounds good to me.

Acked-by: Thomas Huth <thuth@redhat.com>


