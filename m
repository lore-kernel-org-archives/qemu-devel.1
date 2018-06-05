Received: from eggs.gnu.org ([2001:4830:134:3::10]:33580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQAcK-0004jo-4k
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQAcG-0001Rd-8o
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:59:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQAcG-0001RH-49
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62C31E44B5
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 11:59:07 +0000 (UTC)
Date: Tue, 5 Jun 2018 12:59:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605115902.GY32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-2-berrange@redhat.com>
	<2604e5d5-0e56-62e7-91eb-fd207a907ac8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2604e5d5-0e56-62e7-91eb-fd207a907ac8@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vl: don't use RUN_STATE_PRECONFIG
 as initial state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Jun 04, 2018 at 04:21:47PM +0200, Michal Privoznik wrote:
> On 06/04/2018 02:03 PM, Daniel P. Berrang=C3=A9 wrote:
> > @@ -3572,7 +3570,12 @@ int main(int argc, char **argv, char **envp)
> >                  }
> >                  break;
> >              case QEMU_OPTION_preconfig:
> > -                preconfig_exit_requested =3D false;
> > +                if (!runstate_check(RUN_STATE_NONE)) {
> > +                    error_report("'--preconfig' and '--incoming' opt=
ions are "
> > +                                 "mutually exclusive");
> > +                    exit(EXIT_FAILURE);
> > +                }
> > +                runstate_set(RUN_STATE_PRECONFIG);
>=20
> Specifying --preconfig twice on the command line now fails with a very
> cryptic message (there's no --incoming).

This can be addressed with a slight rewording

   "Only a single usage of --preconfig or --incoming is permitted"

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
