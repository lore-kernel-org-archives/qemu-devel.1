Received: from eggs.gnu.org ([2001:4830:134:3::10]:53861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehJMa-0000Dn-Nw
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ehJMW-000640-MD
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:13:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ehJMW-00062m-GK
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:13:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5772356FF
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 18:13:27 +0000 (UTC)
Date: Thu, 1 Feb 2018 18:13:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180201181321.GZ22810@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180125143218.29528-1-kraxel@redhat.com>
	<20180125143218.29528-3-kraxel@redhat.com>
	<65124689-6705-71ee-561c-8d4b25b30e16@redhat.com>
	<20180201173529.GX22810@redhat.com>
	<6199d545-e7ae-ad95-6695-a63a714cb45c@redhat.com>
	<20180201175444.GY22810@redhat.com>
	<1f7763b2-44ec-0663-d721-7a71782592a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f7763b2-44ec-0663-d721-7a71782592a6@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/8] ui: convert the SDL2 frontend to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Thu, Feb 01, 2018 at 01:10:34PM -0500, Paolo Bonzini wrote:
> On 01/02/2018 12:54, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Feb 01, 2018 at 12:37:26PM -0500, Paolo Bonzini wrote:
> >> On 01/02/2018 12:35, Daniel P. Berrang=C3=A9 wrote:
> >>> On Thu, Feb 01, 2018 at 12:28:02PM -0500, Paolo Bonzini wrote:
> >>>> On 25/01/2018 09:32, Gerd Hoffmann wrote:
> >>>>> --- a/include/ui/input.h
> >>>>> +++ b/include/ui/input.h
> >>>>> @@ -80,4 +80,7 @@ extern const guint16 qemu_input_map_qnum_to_qco=
de[];
> >>>>>  extern const guint qemu_input_map_qcode_to_linux_len;
> >>>>>  extern const guint16 qemu_input_map_qcode_to_linux[];
> >>>>
> >>>> Is there any reason to use the length variables rather than just
> >>>> ARRAY_SIZE()?  Coverity isn't able to see through the initializer =
and
> >>>> incorrectly complains that
> >>>
> >>> ARRAY_SIZE can only be used if you can see the array variable
> >>> initialization, but this is the header file so all we have is
> >>> the extern declaration and thus the array size is unknown from
> >>> the places that need to use the _len variable.
> >>>
> >>> We do in fact initalize the _len variable based on the ARRAY_SIZE,
> >>> but that's in the .c files.
> >>
> >> Would it make sense for keymap-gen to also generate the header file,=
 so
> >> that we can use an "extern const guint x[NNN]" declaration rather
> >> instead of "x[]"?
> >=20
> > I could probably add such a feature to it....
>=20
> I could too if I know it will be accepted!  I'll send you a patch.

Cool, i accept patches on this list, or a pull request to the master
keycodemap upstream gitlab repo.

My gut feeling is that it'll want to define a new output language
"stdc-hdr" to generate the C header. See  'SRC_GENERATORS' table
in the tool. There's also a tests/ directory ... :-)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
