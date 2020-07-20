Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6239BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C1612068F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="UAa2CdX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1612068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxTNx-00088I-CK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jxTNM-0007jG-2L
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:50:28 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:41834 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jxTNF-0006qq-NZ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:50:27 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 65B684AC44;
 Mon, 20 Jul 2020 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1595242216; x=1597056617; bh=1n2ENw8MD4MgJw4mtJV8pz
 uXCj+SaOHa3VPZT5hM3y0=; b=UAa2CdX5JTCsbf55AY1pS6S5qeaxmtjh59ezd2
 M0kuhVf8KOR+gBilZM7H8Gh4ejFhSCfABlCFO5RX153ZJ+Hyj6mNyeu8A3xxFRyU
 s9Mzs89sH0KTXsngIYf41sR1MWWkYSlxn4zi1xfx+TSWUQNCmO/E3RU+SKRaf4/I
 T9rKg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u2JsqkoxJ_F6; Mon, 20 Jul 2020 13:50:16 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id B5432499B7;
 Mon, 20 Jul 2020 13:50:16 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 20
 Jul 2020 13:50:16 +0300
Date: Mon, 20 Jul 2020 13:50:15 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/4] scripts/tracetool: Fix dtrace generation for macOS
Message-ID: <20200720105015.GA73320@SPB-NB-133.local>
References: <20200717093517.73397-1-r.bolshakov@yadro.com>
 <20200717093517.73397-2-r.bolshakov@yadro.com>
 <34c236c5-e047-6f15-6bb6-d0df65129622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34c236c5-e047-6f15-6bb6-d0df65129622@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 06:50:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 19, 2020 at 03:52:08PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/17/20 11:35 AM, Roman Bolshakov wrote:
> > dtrace USDT is fully supported since OS X 10.6. There are a few
> > peculiarities compared to other dtrace flavors.
> > 
> > 1. It doesn't accept empty files.
> > 2. It doesn't recognize bool type but accepts C99 _Bool.
> > 3. It converts int8_t * in probe points to char * in
> >    header files and introduces [-Wpointer-sign] warning.
> > 
> > Cc: Cameron Esfahani <dirty@apple.com>
> > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > ---
> >  scripts/tracetool/format/d.py | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
> > index 0afb5f3f47..353722f89c 100644
> > --- a/scripts/tracetool/format/d.py
> > +++ b/scripts/tracetool/format/d.py
> > @@ -13,6 +13,7 @@ __email__      = "stefanha@redhat.com"
> >  
> >  
> >  from tracetool import out
> > +from sys import platform
> >  
> >  
> >  # Reserved keywords from
> > @@ -34,7 +35,8 @@ def generate(events, backend, group):
> >  
> >      # SystemTap's dtrace(1) warns about empty "provider qemu {}" but is happy
> >      # with an empty file.  Avoid the warning.
> > -    if not events:
> > +    # But dtrace on macOS can't deal with empty files.
> > +    if not events and platform != "darwin":
> 
> or?

no, the event list is empty for some files where all events are
disabled (e.g. hppa/trace-events), so it should have an "and" here. This
limits early exit only on macOS. The precendence looks correct:

https://docs.python.org/3/reference/expressions.html#operator-precedence

> 
> >          return
> >  
> >      out('/* This file is autogenerated by tracetool, do not edit. */'
> > @@ -44,6 +46,17 @@ def generate(events, backend, group):
> >      for e in events:
> >          args = []
> >          for type_, name in e.args:
> > +            if platform == "darwin":
> > +                # macOS dtrace accepts only C99 _Bool
> 
> Why not do that for all platforms?
> 

Because I can only test the changes on darwin :)
I don't know how other dtrace flavors behave and whether it is an issue
for dtrace on Linux/Solaris/FreeBSD/etc.

Thanks,
Roman

> > +                if type_ == 'bool':
> > +                    type_ = '_Bool'
> > +                if type_ == 'bool *':
> > +                    type_ = '_Bool *'
> > +                # It converts int8_t * in probe points to char * in header
> > +                # files and introduces [-Wpointer-sign] warning.
> > +                # Avoid it by changing probe type to signed char * beforehand.
> > +                if type_ == 'int8_t *':
> > +                    type_ = 'signed char *'
> >              if name in RESERVED_WORDS:
> >                  name += '_'
> >              args.append(type_ + ' ' + name)
> > 
> 

