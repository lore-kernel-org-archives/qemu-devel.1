Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKUu-0007EV-TV
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dJKUr-0001AH-QE
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dJKUr-0001A5-Kb
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:02:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98FF58553E
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 14:02:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
Date: Fri, 09 Jun 2017 16:02:37 +0200
In-Reply-To: <1496980142-8986-1-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Fri, 9 Jun 2017 11:48:56 +0800")
Message-ID: <877f0lgsxu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] migration: objectify MigrationState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

Test compile gripes:

    hw/xen/xen-common.c: In function =E2=80=98xen_init=E2=80=99:
    hw/xen/xen-common.c:147:5: warning: implicit declaration of function =
=E2=80=98register_compat_prop=E2=80=99 [-Wimplicit-function-declaration]
         register_compat_prop("migration", "store-global-state", "off");
         ^~~~~~~~~~~~~~~~~~~~
    hw/xen/xen-common.c:147:5: warning: nested extern declaration of =E2=80=
=98register_compat_prop=E2=80=99 [-Wnested-externs]

You might want to install Xen development packages to catch such issues
earlier.

Test run:

    $ qemu-system-x86_64 -device migration,help
    migration.skip-section-footer=3Dbool
    migration.store-global-state=3Dbool
    migration.only-migratable=3Dbool
    migration.skip-configuration=3Dbool

What would adding this device do?
