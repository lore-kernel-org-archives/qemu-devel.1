Received: from eggs.gnu.org ([2001:4830:134:3::10]:46641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQ02q-0003DU-Sw
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 20:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQ02n-0007ep-Q6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 20:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fQ02n-0007eM-KS
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 20:41:49 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0A0A3181487
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 00:41:48 +0000 (UTC)
Date: Mon, 4 Jun 2018 21:41:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180605004146.GD3184@localhost.localdomain>
References: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>
	<20180604103244.GD19749@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180604103244.GD19749@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cli: Don't run early event loop if no
 --preconfig was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, imammedo@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

On Mon, Jun 04, 2018 at 11:32:44AM +0100, Daniel P. Berrang=E9 wrote:
[...]
> Avoiding the double-run of main_loop is good, however, I think we shoul=
d
> also not have put current_run_state in RUN_STATE_PRECONFIG in the first
> place if --preconfig wasn't set.  I've sent a patch to fix that problem
> too, so if yours is also applied, it could be changed to just do:
>=20
>     if (current_run_state =3D=3D RNU_STATE_PRECONFIG) {
>         main_loop();
>     }

So, this patch is desirable even if we refactor the state machine
as suggested in the other threads, right?

I'm queueing it on machine-next right now.

--=20
Eduardo
