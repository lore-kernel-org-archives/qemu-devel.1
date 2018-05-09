Received: from eggs.gnu.org ([2001:4830:134:3::10]:46788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGKWn-0003NC-BS
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGKWi-0003k0-AN
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:32:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGKWi-0003jF-6J
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:32:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A07D88182D1C
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 08:32:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180502171938.GJ2679@work-vm> (David Alan Gilbert's message of
	"Wed, 2 May 2018 18:19:39 +0100")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-9-quintela@redhat.com>
	<20180502171938.GJ2679@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 09 May 2018 10:34:57 +0200
Message-ID: <871sel6xce.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v12 08/21] migration: Transmit initial
 package through the multifd channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Please print the magic with %x.

done.

>
>> +        return -1;
>> +    }
>> +
>> +    if (msg.version !=3D MULTIFD_VERSION) {
>> +        error_setg(errp, "multifd: received packet version %d "
>> +                   "expected %d", msg.version, MULTIFD_VERSION);
>> +        return -1;
>> +    }
>> +
>> +    if (memcmp(msg.uuid, &qemu_uuid, sizeof(qemu_uuid))) {
>> +        char *uuid =3D qemu_uuid_unparse_strdup(&qemu_uuid);
>> +        error_setg(errp, "multifd: received uuid '%s' and expected "
>> +                   "uuid '%s' for channel %hhd", msg.uuid, uuid, msg.id=
);
>
> I don't think you can just print msg.uuid there; it's the raw 16 bytes
> isn't it rather than a string?

You ae right.

> I suspect you need to do the unprase on both of them.

Done.

Thanks, Juan.
