Received: from eggs.gnu.org ([2001:4830:134:3::10]:47417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG0O2-0004BL-Uf
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG0Nx-0001ag-Ct
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:02:27 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG0Nx-0001aE-8A
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:02:21 -0400
Received: by mail-ot0-x244.google.com with SMTP id t1-v6so35532585ott.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 04:02:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508113425.003c5031@bahia.lan>
References: <152568372989.443627.900708381919207053.stgit@bahia.lan>
	<71b68bd5-e50b-3baa-3f72-f6af78db4e2e@redhat.com>
	<20180508113425.003c5031@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 12:01:59 +0100
Message-ID: <CAFEAcA8bbdzEPZLA1sTXH-eGeOPUZw8f=p3_a9c4ERq35+mDew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc: e500: use g_strdup_printf() instead
 of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 8 May 2018 at 10:34, Greg Kurz <groug@kaod.org> wrote:
> On Mon, 7 May 2018 12:53:45 -0500
> Eric Blake <eblake@redhat.com> wrote:
>
>> On 05/07/2018 04:02 AM, Greg Kurz wrote:
>> > qemu-system-ppc fails to build with GCC 8.0.1:
>> >
>> > /home/hsp/src/qemu-master/hw/ppc/e500.c: In function =E2=80=98ppce500_=
load_device_tree=E2=80=99:
>> > /home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic@=
=E2=80=99
>> > directive output may be truncated writing 5 bytes into a region of
>> > size between 1 and 128 [-Werror=3Dformat-truncation=3D]
>> >       snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_RE=
GS_OFFSET);
>> >                                       ^~~~~
>>
>> >
>> > Fix this by converting e500 to use g_strdup_printf()+g_free() instead
>> > of snprintf(). This is done globally, even for call sites that don't
>> > break build, since this is the preferred practice in QEMU.
>> >
>> > Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
>> > Signed-off-by: Greg Kurz <groug@kaod.org>
>> > ---
>> >   hw/ppc/e500.c |   39 +++++++++++++++++++++++----------------
>> >   1 file changed, 23 insertions(+), 16 deletions(-)
>> >
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>
> Hi Peter,
>
> David said the next pull request for ppc would happen in a month. This
> patch fixes an annoying build break with recent GCC, and it already
> got two positive reviews, is it possible to have it merged upstream ?

Sure; applied to master.

-- PMM
