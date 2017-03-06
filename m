Received: from eggs.gnu.org ([2001:4830:134:3::10]:46468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckjrS-0003fn-JI
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckjrP-0002fr-FV
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:03:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ckjrP-0002fk-9s
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:02:59 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 644EAFAF3C
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 04:02:58 +0000 (UTC)
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
	<20170303103919.GA2439@work-vm>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bebb011d-5cf9-c33a-5920-a029cae5f558@redhat.com>
Date: Mon, 6 Mar 2017 12:02:52 +0800
MIME-Version: 1.0
In-Reply-To: <20170303103919.GA2439@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] migration: expose qemu_announce_self()
 via qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Germano Veit Michel <germano@redhat.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Juan Jose Quintela Carreira <quintela@redhat.com>



On 2017=E5=B9=B403=E6=9C=8803=E6=97=A5 18:39, Dr. David Alan Gilbert wrot=
e:
> * Germano Veit Michel (germano@redhat.com) wrote:
>> qemu_announce_self() is triggered by qemu at the end of migrations
>> to update the network regarding the path to the guest l2addr.
>>
>> however it is also useful when there is a network change such as
>> an active bond slave swap. Essentially, it's the same as a migration
>> from a network perspective - the guest moves to a different point
>> in the network topology.
>>
>> this exposes the function via qmp.
> Markus: Since you're asking for tests for qmp commands; how would you
> test this?
>
> Jason: Does this look OK from the networking side of things?
>

Good as a start I think. We probably want to add callbacks for each=20
kinds of nic. This will be useful for virtio, since some guest can=20
announce themselves with complex configurations (e.g vlans).

Thanks
