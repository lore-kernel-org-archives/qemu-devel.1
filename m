Received: from eggs.gnu.org ([2001:4830:134:3::10]:46214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eYZl6-0002qK-5c
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eswierk@skyportsystems.com>) id 1eYZl4-0006a5-V3
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:54:44 -0500
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:45111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eswierk@skyportsystems.com>)
	id 1eYZl4-0006Zs-Pf
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:54:42 -0500
Received: by mail-io0-x231.google.com with SMTP id e20so14548640iof.12
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 07:54:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
	<CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
	<4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Mon, 8 Jan 2018 07:54:01 -0800
Message-ID: <CAO_EM_=NgT1f+bM7_2ztw1S0ZvkDYZyJjwvRMWV6FVyvODMWfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Mon, Jan 8, 2018 at 7:10 AM, Eric Blake <eblake@redhat.com> wrote:
>
> On 01/08/2018 07:30 AM, Ed Swierk via Qemu-devel wrote:
>
> > Applied, thanks.
> >
> > PS: just noticed, but "Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>"
> > is a bit of an odd Author string to end up in git commit logs, so you
> > and/or Ed might like to fix that up for any future patches.
> >
> >
> > Thanks for pointing that out. I wonder if it's happening because I let
> > git-send-email automatically fill in the From: line.
>
> It's also a factor of how strict your ISP is about DMARC handling; the
> list automatically rewrites the 'From:' header to insert the 'via
> Qemu-devel' tag if it detects DMARC settings at your ISP that won't
> allow your email through as originally written.  Sadly, mailman doesn't
> know to insert a manual 'From:' line in the body when it rewrites the
> original From: header; but if you know that DMARC settings are going to
> munge your original header, you can probably convince git to always
> insert an explicit From: line in the message body to override whatever
> munging the list does.

I'm trying to figure out what I need to fix on my end. I went back and
looked at the email headers. Here are the two that ended up with the
wrong author:

Return-Path: <eswierk@skyportsystems.com>
Received: from eswierk-sc.localdomain
(67-207-112-138.static.wiline.com. [67.207.112.138])
        by smtp.gmail.com with ESMTPSA id
d9sm20150979pfk.117.2017.11.14.15.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 15:23:44 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
To: Jason Wang <jasowang@redhat.com>,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
        Ed Swierk <eswierk@skyportsystems.com>
Subject: [PATCH 1/2] e1000, e1000e: Move per-packet TX offload flags
out of context state
Date: Tue, 14 Nov 2017 15:23:33 -0800
Message-Id: <1510701814-52973-2-git-send-email-eswierk@skyportsystems.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
References: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>

Return-Path: <eswierk@skyportsystems.com>
Received: from eswierk-sc.localdomain
(67-207-112-138.static.wiline.com. [67.207.112.138])
        by smtp.gmail.com with ESMTPSA id
d9sm20150979pfk.117.2017.11.14.15.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Nov 2017 15:23:45 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
To: Jason Wang <jasowang@redhat.com>,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
        Ed Swierk <eswierk@skyportsystems.com>
Subject: [PATCH 2/2] e1000: Separate TSO and non-TSO contexts, fixing
UDP TX corruption
Date: Tue, 14 Nov 2017 15:23:34 -0800
Message-Id: <1510701814-52973-3-git-send-email-eswierk@skyportsystems.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>
References: <1510701814-52973-1-git-send-email-eswierk@skyportsystems.com>


This one had the correct author:

Return-Path: <eswierk@skyportsystems.com>
Received: from eswierk-sc.localdomain
(67-207-112-138.static.wiline.com. [67.207.112.138])
        by smtp.gmail.com with ESMTPSA id s3sm4082810pfk.7.2017.11.16.06.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 06:06:37 -0800 (PST)
From: Ed Swierk <eswierk@skyportsystems.com>
To: Jason Wang <jasowang@redhat.com>,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org,
        Ed Swierk <eswierk@skyportsystems.com>
Subject: [PATCH v3 REPOST] net: Transmit zero UDP checksum as 0xFFFF
Date: Thu, 16 Nov 2017 06:06:06 -0800
Message-Id: <1510841166-40615-1-git-send-email-eswierk@skyportsystems.com>
X-Mailer: git-send-email 1.9.1


Is there any way to tell exactly what mailman didn't like about the
first two, causing it to change the author?

--Ed
