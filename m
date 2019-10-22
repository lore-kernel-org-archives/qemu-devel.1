Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB01CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 20:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C135C214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 20:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItoCJbCA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C135C214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN0kR-0001WK-Ur
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 16:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iN0jg-0000x0-Mp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 16:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iN0je-0006wB-CD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 16:26:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iN0je-0006uU-3k
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 16:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571775988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdc97wci8kNClnDTTm7pH4/DLK1wuIJ8vjL7OjDSiqY=;
 b=ItoCJbCAKkaRh93Vc1zRiU4S/HcBwpoi9NX9ecsqicydG4qYDGkkveOKWq+zmK/n21Q+35
 9kG/0oRi3C/+11DcHegBFB73IECAJuILoFA5LfSN/MEsv8wODLFtsEPQUJ37MNIJmqeWl+
 5C4R0oYoQKpVF6OoFJ/kkNXzYsRWMgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-p9lrmkTZPUaxoEb87YGxRA-1; Tue, 22 Oct 2019 16:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A05B1800D49;
 Tue, 22 Oct 2019 20:26:24 +0000 (UTC)
Received: from localhost (ovpn-116-104.gru2.redhat.com [10.97.116.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 01F8A6031F;
 Tue, 22 Oct 2019 20:26:05 +0000 (UTC)
Date: Tue, 22 Oct 2019 17:26:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 00/10] image-fuzzer: Port to Python 3
Message-ID: <20191022202603.GB4084@habkost.net>
References: <20191016192430.25098-1-ehabkost@redhat.com>
 <318ecbf2-b077-1a5d-b7d5-a2fc1c9c1c96@redhat.com>
 <20191017212927.GI4084@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20191017212927.GI4084@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: p9lrmkTZPUaxoEb87YGxRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 06:29:27PM -0300, Eduardo Habkost wrote:
> On Thu, Oct 17, 2019 at 05:11:29PM -0400, John Snow wrote:
> >=20
> >=20
> > On 10/16/19 3:24 PM, Eduardo Habkost wrote:
> > > This series ports image-fuzzer to Python 3.
> > >=20
> > > Eduardo Habkost (10):
> > >   image-fuzzer: Open image files in binary mode
> > >   image-fuzzer: Write bytes instead of string to image file
> > >   image-fuzzer: Explicitly use integer division operator
> > >   image-fuzzer: Use io.StringIO
> > >   image-fuzzer: Use %r for all fiels at Field.__repr__()
> > >   image-fuzzer: Return bytes objects on string fuzzing functions
> > >   image-fuzzer: Use bytes constant for field values
> > >   image-fuzzer: Encode file name and file format to bytes
> > >   image-fuzzer: Run using python3
> > >   image-fuzzer: Use errors parameter of subprocess.Popen()
> > >=20
> > >  tests/image-fuzzer/qcow2/__init__.py |  1 -
> > >  tests/image-fuzzer/qcow2/fuzz.py     | 54 +++++++++++++-------------
> > >  tests/image-fuzzer/qcow2/layout.py   | 57 ++++++++++++++------------=
--
> > >  tests/image-fuzzer/runner.py         | 12 +++---
> > >  4 files changed, 61 insertions(+), 63 deletions(-)
> > >=20
> >=20
> > When I gave my try at converting this to python3 I noticed that the
> > "except OSError as e" segments used e[1] in a way that was not seemingl=
y
> > supported.
> >=20
> > Did you fix that in this series or did I miss it?
>=20
> Good catch, I hadn't noticed that.  I didn't fix it.

Separate patch sent for that issue:
https://lore.kernel.org/qemu-devel/20191021214117.18091-1-ehabkost@redhat.c=
om/

--=20
Eduardo


