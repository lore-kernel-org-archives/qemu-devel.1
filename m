Received: from eggs.gnu.org ([2001:4830:134:3::10]:58932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fno7R-00046t-0i
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fno7N-0002Se-Ud
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:49:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45620 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fno7N-0002SM-PP
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:48:57 -0400
References: <1533796396-20483-1-git-send-email-whois.zihan.yang@gmail.com>
	<d8474720-729d-a44c-a329-9adbff6d9027@redhat.com>
	<CAKwiv-j16RoLy0oXUa+NY2eMW8s12E2+vFjxy8Y4J_bOM=Sm+A@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1cf87364-5a10-bf64-dbfa-981456ecf365@redhat.com>
Date: Thu, 9 Aug 2018 11:48:56 -0500
MIME-Version: 1.0
In-Reply-To: <CAKwiv-j16RoLy0oXUa+NY2eMW8s12E2+vFjxy8Y4J_bOM=Sm+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Zihan Yang <whois.zihan.yang@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 08/09/2018 11:39 AM, Zihan Yang wrote:
> Eric Blake <eblake@redhat.com> =E4=BA=8E2018=E5=B9=B48=E6=9C=889=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:23=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On 08/09/2018 01:33 AM, Zihan Yang wrote:
>>> The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by def=
ault,
>>> change it to a new type TYPE_PXB_PCIE_HOST to better utilize ECAM of =
PCIe
>>
>> meta-comment:
>>
>> Your messages came through unthreaded (seven separate threads), rather
>> than properly marked 'References:' and 'In-reply-to:' to the 0/6 cover
>> letter <1533796115-15837-1-git-send-email-whois.zihan.yang@gmail.com>,
>> which makes it a bit harder to keep track of the conversation when
>> viewing mails sorted by threads with most recent activity.
>=20
> My mistake, I manually added the cc of cover letter, which is not
> covered by cccmd,
> but I didn't add In-reply-to of remaining mails. I will directly add
> an "cc: " field in cover
> letter and send them all in later patches to avoid breaking them up.
>=20
> As for this patch set, should I resend them or save it to v5, which I
> will try working out
> this weekend?

At this point, it's probably still worth waiting for any comments on v4,=20
so that v5 can fix those issues.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
