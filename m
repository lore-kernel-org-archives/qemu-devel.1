Received: from eggs.gnu.org ([2001:4830:134:3::10]:54790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fnnyd-00075p-OZ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:39:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fnnyd-000412-0g
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:39:55 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fnnyc-0003yw-Oq
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:39:54 -0400
Received: by mail-lf1-x144.google.com with SMTP id j8-v6so4571271lfb.4
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 09:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <1533796396-20483-1-git-send-email-whois.zihan.yang@gmail.com>
	<d8474720-729d-a44c-a329-9adbff6d9027@redhat.com>
In-Reply-To: <d8474720-729d-a44c-a329-9adbff6d9027@redhat.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Fri, 10 Aug 2018 00:39:41 +0800
Message-ID: <CAKwiv-j16RoLy0oXUa+NY2eMW8s12E2+vFjxy8Y4J_bOM=Sm+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 1/6] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Eric Blake <eblake@redhat.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On 08/09/2018 01:33 AM, Zihan Yang wrote:
> > The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by defau=
lt,
> > change it to a new type TYPE_PXB_PCIE_HOST to better utilize ECAM of PC=
Ie
>
> meta-comment:
>
> Your messages came through unthreaded (seven separate threads), rather
> than properly marked 'References:' and 'In-reply-to:' to the 0/6 cover
> letter <1533796115-15837-1-git-send-email-whois.zihan.yang@gmail.com>,
> which makes it a bit harder to keep track of the conversation when
> viewing mails sorted by threads with most recent activity.

My mistake, I manually added the cc of cover letter, which is not
covered by cccmd,
but I didn't add In-reply-to of remaining mails. I will directly add
an "cc: " field in cover
letter and send them all in later patches to avoid breaking them up.

As for this patch set, should I resend them or save it to v5, which I
will try working out
this weekend?
