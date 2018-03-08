Received: from eggs.gnu.org ([2001:4830:134:3::10]:44465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1etjSd-0001tJ-EU
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:31:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1etjSc-0000u7-10
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:31:07 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:45311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1etjSb-0000tW-Jq
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:31:05 -0500
Received: by mail-lf0-x244.google.com with SMTP id h127-v6so5874828lfg.12
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 16:31:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <487a4895-e076-e7f5-0f05-fafbd1c435fe@amsat.org>
References: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
	<CAKwiv-h4HJkt3QM-dakH54CY_1wgDkGtt5+wTQg396TdH_CUXw@mail.gmail.com>
	<487a4895-e076-e7f5-0f05-fafbd1c435fe@amsat.org>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu, 8 Mar 2018 08:31:03 +0800
Message-ID: <CAKwiv-hn=8+_eg=oRaPNCQ=Uirn6and-60wpo5jH5Wtq6qj7VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] vmmouse: convert qdev pointer property
 to QOM link relationship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

 Hi Philippe,

Thanks for reviewing my patch. Yes I though about it, a specific header fil=
e
with only several lines seems not worth it, but otherwise I would have to
define redundant macro in vmmouse.c. Currently rebundant macro is ok
but if we need some more macros, we would end on creating a specific
header at last, although I'm not sure whether we will really need more
macros in the future.

P.S. I forgot to cc to qemu-devel, so I resend one. I apologize if two
identical
emails look confusing to you.

2018-03-08 4:27 GMT+08:00 Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> Hi Zihan Yang,
>
> On 03/07/2018 01:55 PM, Zihan Yang wrote:
> >  Hi all, this is a bitesized patch from me a while ago, it seems a litt=
le
> > old but I wonder if there is any opinion about it? Is it still valid?
>
> For a single TYPE use, I'm not sure use a specific header is useful
> (patch #1).
> The 2nd patch looks valid to me but I'm not a QOM link expert.
>
> >
> > Thanks.
> >
> > 2018-02-04 15:28 GMT+08:00 Zihan Yang <whois.zihan.yang@gmail.com>:
> >
> >> The ps2_mouse property of vmmouse is still pointer type which
> >> is defined by DEFINE_PROP_PTR. But qdev pointer property should
> >> be avoided according to qdev-properties.h. Convert it to
> >> QOM link relationship.
> >>
> >> It involves two patches because it requires the TYPE_I8042
> >> macro which is defined in another file. The first patch put
> >> this macro into a single header file so that the macro can
> >> be used elsewhere. The second patch does the actual work.
> >>
> >> Zihan Yang (2):
> >>   hw/input/pckdb: put TYPE_I8042 into a single header file
> >>   vmmouse: change qdev pointer property to qom link
> >>
> >>  hw/i386/pc.c      |  2 +-
> >>  hw/i386/vmmouse.c | 19 ++++++++++++-------
> >>  hw/input/pckbd.c  |  2 +-
> >>  hw/input/pckbd.h  |  6 ++++++
> >>  4 files changed, 20 insertions(+), 9 deletions(-)
> >>  create mode 100644 hw/input/pckbd.h
> >>
> >> --
> >> 2.7.4
> >>
> >>
>
