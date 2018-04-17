Received: from eggs.gnu.org ([2001:4830:134:3::10]:48395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8RfP-0007fN-Jm
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f8RfH-00015v-TW
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:33:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f8RfH-00015i-PR
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 10:32:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F279D406E8B9
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 14:32:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
	<7413bf34-63ec-837d-d418-af2cfd1038d7@redhat.com>
	<87efjeaqd2.fsf@dusky.pond.sub.org>
	<20180417140540.GD15421@redhat.com>
	<21d78c43-a6d9-95d8-ff3e-f80a9ce6b0c0@redhat.com>
Date: Tue, 17 Apr 2018 16:32:50 +0200
In-Reply-To: <21d78c43-a6d9-95d8-ff3e-f80a9ce6b0c0@redhat.com> (Paolo
	Bonzini's message of "Tue, 17 Apr 2018 16:14:02 +0200")
Message-ID: <87po2x6gz1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 17/04/2018 16:05, Daniel P. Berrang=C3=A9 wrote:
>>> For what it's worth, my "[RFC PATCH 00/32] Command line QAPIfication"
>>> replaces the original parsing art by getopt_long_only().
>>>
>>> Completing that work will take some time, but once it's done, we can
>>> (and I think we should) prefer double-dash for consistency.
>> Since our existing parser accepts single & double-dash already, is it
>> worth explicitly deprecating single-dash usage right now. So that when
>> your code comes along ready to merge, we're already able to say
>> "i told you so" and drop single-dash support at that same time.
>
> Serious questions: is _anyone_ of you actually using double-dash support
> in daily invocations of QEMU?

I use both.  I readily concede that people familiar with QEMU probably
use single dash a lot more than double dash.  I don't think we should
get rid of single dash, unless we decide to bite the bullet and clean up
our command line without regard for backward compatibility, as Thomas
proposed elsewhere in this thread, and others proposed before, multiple
times.

I don't entertain the idea of compatibility breaks lightly.  But our
command line is genuinely nasty.  The closer you look, the nastier.
