Received: from eggs.gnu.org ([2001:4830:134:3::10]:37934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gXR1V-0006g2-Hu
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gXR1U-0001vo-2V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:27:29 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gXR1S-0001qX-0U
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:27:27 -0500
Received: by mail-oi1-x243.google.com with SMTP id y23so1601856oia.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 05:27:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jFj3SjX-yiTWYx9MCKTwfX4F-4jw9fVmVVK4So=bdPzA@mail.gmail.com>
References: <20181212102548.27626-1-alex.bennee@linaro.org>
	<CAL1e-=jFj3SjX-yiTWYx9MCKTwfX4F-4jw9fVmVVK4So=bdPzA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 13 Dec 2018 14:27:15 +0100
Message-ID: <CAL1e-=jJHGH+zB0FJWxX3QTZNy1t3kGT1BX2hZUrQomtvwtV8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Dec 13, 2018 2:45 AM, aleksandar.m.mail@gmail.com wrote:
>
>
> On Dec 12, 2018 11:26 AM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wro=
te:
> >
> > This is a QEMU specific version of a gitdm config for generating
> > reports on the contributor base of the project. I've added enough
> > group maps and domain aliases to ensure the current top ten is as
> > reflective as it can be. As of this commit running:
> >
> >   git log --numstat --since "Last Year" | gitdm -n -l 10
> >
> > Reports:
> >
> >   Top changeset contributors by employer
> >   Red Hat                   3126 (44.0%)
> >   Linaro                    1166 (16.4%)
> >   (None)                     684 (9.6%)
> >   IBM                        348 (4.9%)
> >   Virtuozzo                  168 (2.4%)
> >   Xilinx                     102 (1.4%)
> >   Wave Computing             101 (1.4%)
> >   Igalia                      93 (1.3%)
> >   Cadence Design Systems      88 (1.2%)
> >   SiFive                      59 (0.8%)
> >
> >   Top lines changed by employer
> >   Red Hat                   143166 (27.9%)
> >   Cadence Design Systems    126554 (24.6%)
> >   Linaro                    78845 (15.3%)
> >   Wave Computing            32263 (6.3%)
> >   (None)                    21789 (4.2%)
> >   SiFive                    14392 (2.8%)
> >   IBM                       12219 (2.4%)
> >   Virtuozzo                 10445 (2.0%)
> >   CodeWeavers               9179 (1.8%)
> >   Xilinx                    4572 (0.9%)
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> > ---
> > v2
> >   - use aliases instead of .mailmap
> >   - add more companies to domainmap
> >   - add more groups to cover non-corporate email
> >   - add an individuals group-map for (None)
> >   - limit the stats to top ten
> > ---
> >  contrib/gitdm/aliases               |  27 +++
> >  contrib/gitdm/domain-map            |  18 ++
> >  contrib/gitdm/filetypes.txt         | 362 ++++++++++++++++++++++++++++
> >  contrib/gitdm/group-map-cadence     |   3 +
> >  contrib/gitdm/group-map-codeweavers |   1 +
> >  contrib/gitdm/group-map-ibm         |   6 +
> >  contrib/gitdm/group-map-redhat      |   7 +
> >  contrib/gitdm/group-map-wavecomp    |   9 +
> >  gitdm.config                        |  48 ++++
> >  9 files changed, 481 insertions(+)
> >
>
> ...
>
> > +++ b/contrib/gitdm/group-map-wavecomp
> > @@ -0,0 +1,9 @@
> > +#
> > +# Wave Computing acquired MIPS in June 2018 from imgtec
> > +#
> > +
> > +amarkovic@wavecomp.com
> > +smarkovic@wavecomp.com
> > +paul.burton@imgtec.com
> > +yongbok.kim@imgtec.com
> > +yongbok.kim@mips.com
>
> Alex! Thanks for this idea, and efforts!
>
> However, the ownership of MIPS was more complex than stated in the
comment above. Up to Feb 2013 we had mips.com mails, then up to Oct 2017
imgtec.com mails, then up to June 2018 again mips.com mails, and from then
on wavecomp.com mails. See Wikipedia article for mips for details. I would
modify the comment above to say:
>
> " Wave Computing acquired MIPS in June 2018. Also, from February 2013 to
October 2017, MIPS was owned by Imagination Technologies."
>
> Also, the email list should be extended to be something like this:
>
> amarkovic@wavecomp.com
> arikalo@wavecomp.com
> dnikolic@wavecomp.com
> pburton@wavecomp.com
> smarkovic@wavecomp.com
> ysu@wavecomp.com
> aleksandar.markovic@imgtec.com
> paul.burton@imgtec.com
> yongbok.kim@imgtec.com
> aleksandar.markovic@mips.com
> matthew.fortune@mips.com
> yongbok.kim@mips.com
>
I forgot

james.hogan@mips.com

who also had some contribution in August this year.

> Otherwise:
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
