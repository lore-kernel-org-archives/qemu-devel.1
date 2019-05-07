Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2987C04A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98942206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98942206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNoOj-0004qI-S9
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 20:55:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hNoMu-0003Bu-GI
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hNoMs-0006lD-Lp
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:54:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hNoMr-0006j3-A8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:54:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5B4D3086272;
	Tue,  7 May 2019 00:53:59 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F7B661F21;
	Tue,  7 May 2019 00:53:56 +0000 (UTC)
Date: Mon, 6 May 2019 21:53:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190507005355.GJ28722@habkost.net>
References: <20190503193721.18459-1-ehabkost@redhat.com>
	<871s1br7t9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s1br7t9.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 07 May 2019 00:53:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Deprecate Python 2 support
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 04:12:02PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > Python 2 will reach end of life in January 1 2020.  Declare it as
> > deprecated.
> >
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  configure            | 8 ++++++++
> >  qemu-deprecated.texi | 8 ++++++++
> >  2 files changed, 16 insertions(+)
> >
> > diff --git a/configure b/configure
> > index 5b183c2e39..50385061ed 100755
> > --- a/configure
> > +++ b/configure
> > @@ -6461,6 +6461,14 @@ if test "$supported_os" = "no"; then
> >      echo "us upstream at qemu-devel@nongnu.org."
> >  fi
> >  
> > +# Note that if the Python conditional here evaluates True we will exit
> > +# with status 1 which is a shell 'false' value.
> > +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
> > +  echo
> > +  echo "WARNING: Python 2 support is deprecated" >&2
> > +  echo "WARNING: Python 3 will be required for building future versions of QEMU" >&2
> 
> Please don't shout "warning".  
>
[...]
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!  Queued after changing messages to "warning: ..."

-- 
Eduardo

