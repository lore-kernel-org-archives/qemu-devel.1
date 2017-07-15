Received: from eggs.gnu.org ([2001:4830:134:3::10]:54312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dWHlh-0004hd-3r
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dWHlf-0004Sl-Q0
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:45:36 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:32943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dWHlf-0004SF-ES
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 03:45:35 -0400
Received: by mail-wr0-x233.google.com with SMTP id u110so11386068wrb.0
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 00:45:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170715024202.GH17539@umbus.fritz.box>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
	<CAFEAcA8kQF3xS6=uQiXf6FSbP56xmStPN9SoqWy1cmzMFFUpOQ@mail.gmail.com>
	<20170715024202.GH17539@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 15 Jul 2017 08:45:13 +0100
Message-ID: <CAFEAcA_8nhPXE6y0PnYdQfjwqhqFMzg0wGL=KxgD_xb5jnZnfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170714
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, sbobroff@au1.ibm.com, Laurent Vivier <lvivier@redhat.com>

On 15 July 2017 at 03:42, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Jul 14, 2017 at 04:13:05PM +0100, Peter Maydell wrote:
>> Hi. I'm afraid this fails to build on the w32 compiler:
>>   CC      ppc64-softmmu/hw/ppc/spapr.o
>> /home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c: In function
>> =E2=80=98spapr_get_resize_hpt=E2=80=99:
>> /home/petmay01/linaro/qemu-for-merges/hw/ppc/spapr.c:2642:1: error:
>> control reaches end of non-void functio
>> n [-Werror=3Dreturn-type]
>>  }
>
> Drat.  Is there an easy way to test compile for w32?

I have a cross-compiler set up on an Ubuntu host; you
can do it on Redhat hosts too; instructions on the wiki
somewhere I think.

In this case I think you're either getting caught by the
age of the compiler or because this set of w32 headers
have a bug where assert() doesn't get marked as fatal
somehow, so it might or might not manifest on other
w32 cross build setups.

> Yes, seems good.  Should I resend, or will you adjust in place?

You'll need to resend -- I can't modify signed pull reqs.

thanks
-- PMM
