Received: from eggs.gnu.org ([2001:4830:134:3::10]:52975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enldf-0007Fy-0F
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enldb-0007jI-0A
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:37:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1enlda-0007j5-Ru
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 08:37:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 842F14023EDE
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 13:37:35 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<544057ea-8e87-3aea-e2e0-8225212a7d9b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e6b85c27-f58b-c338-4b45-31f72cb7cf47@redhat.com>
Date: Mon, 19 Feb 2018 14:37:28 +0100
MIME-Version: 1.0
In-Reply-To: <544057ea-8e87-3aea-e2e0-8225212a7d9b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/8] Improvements and clean-ups related
 to -net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 19.02.2018 14:29, Eric Blake wrote:
> On 02/19/2018 03:15 AM, Thomas Huth wrote:
>=20
>> The last patch finally makes "-net" less prominent in our qemu docs,
>> e.g. by replacing the examples that contain "-net" with "-netdev".
>=20
> Minor request: while doing this, can we update the documentation to
> mention "--netdev" and "--n" everywhere we touch things?=C2=A0 See this=
 for
> rationale:
> https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documen=
tation

Yes, I already tried to do that (see the last patch of this series).
Just forgot to use it in the cover letter, too ;-)

 Thomas
