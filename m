Received: from eggs.gnu.org ([2001:4830:134:3::10]:60397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT44S-0005X2-T8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fT44P-0007ot-QL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:36:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fT44P-0007oI-KZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 07:36:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1528861711-23200-1-git-send-email-keno@juliacomputing.com>
	<87y3fjkzry.fsf@dusky.pond.sub.org>
	<20180613094250.56ad943b@bahia.lab.toulouse-stg.fr.ibm.com>
Date: Wed, 13 Jun 2018 13:36:07 +0200
In-Reply-To: <20180613094250.56ad943b@bahia.lab.toulouse-stg.fr.ibm.com> (Greg
	Kurz's message of "Wed, 13 Jun 2018 09:42:50 +0200")
Message-ID: <871sdalxzs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Markus Armbruster <armbru@redhat.com>, Keno Fischer <keno@juliacomputing.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Greg Kurz <groug@kaod.org> writes:

> On Wed, 13 Jun 2018 07:42:57 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Keno Fischer <keno@juliacomputing.com> writes:
>> 
>> > strchrnul is a GNU extension and thus unavailable on a number of targets.
>> > In the review for a commit removing strchrnul from 9p, I was asked to
>> > create a qemu_strchrnul helper to factor out this functionality.
>> > Do so, and use it in a number of other places in the code base that inlined
>> > the replacement pattern in a place where strchrnul could be used.
>> >
>> > Signed-off-by: Keno Fischer <keno@juliacomputing.com>
>> > Acked-by: Greg Kurz <groug@kaod.org>  
>> 
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Maybe I can take this through my 9p-next tree since it is a pre-requisite
> for the Darwin support series ?

Go ahead :)

[...]
