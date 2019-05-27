Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E811C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72C520883
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72C520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48139 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVIWT-0002PY-U1
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:30:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hVIVg-00021e-B6
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hVIVf-0000zX-Dm
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1hVIVf-0000wH-99
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:30:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4446630842CE;
	Mon, 27 May 2019 16:29:49 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 624DA608A4;
	Mon, 27 May 2019 16:29:46 +0000 (UTC)
Message-ID: <2a5ef002257fe66ff6c4c88008ace24f8cffb86f.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 May 2019 18:29:44 +0200
In-Reply-To: <20190524182434.GH10764@habkost.net>
References: <20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
	<20190514090225.vel4xm4x743o4rge@kamzik.brq.redhat.com>
	<20190514164838.48fc7603@Igors-MacBook-Pro>
	<20190515081854.kcpjm4zd2bzc7f6o@kamzik.brq.redhat.com>
	<20190515125229.1784f586@redhat.com>
	<20190515115413.cqvzjkky7xubnsuo@kamzik.brq.redhat.com>
	<2186eb85f8541b0c9cc69cacae9321ace8addaa6.camel@redhat.com>
	<20190524182434.GH10764@habkost.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 27 May 2019 16:29:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
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
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
	"Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Dave.Martin@arm.com,
	dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-05-24 at 15:24 -0300, Eduardo Habkost wrote:
> On Thu, May 23, 2019 at 10:35:24AM +0200, Andrea Bolognani wrote:
> > [...] the above looks good to
> > me as a general direction, but note that you'll have to implement at
> > the very least the query-cpu-model-expansion QMP command for the
> > introspection to work.
> 
> Why is query-cpu-model-expansion needed?  Isn't
> device-list-properties enough?

Good question.

I'll have to check with Jirka, but from playing with both commands
it looks like the latter returns a superset of what the former does,
so for the purpose of figuring out which vector lengths the QEMU
binary recognizes it should be good enough; I suspect, however, that
query-cpu-model-expansion might be (made to be) smarter and for
example not report vector lengths that the underlying hardware
doesn't support, which would be valuable for the purpose of user
friendly error reporting and allowing applications to decide which
vector lengths to request when creating guests.

I'll try to come back with more than theories soon :)

-- 
Andrea Bolognani / Red Hat / Virtualization


