Received: from eggs.gnu.org ([2001:4830:134:3::10]:51469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehdDr-0003eV-4b
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:26:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehdCn-0002vb-1F
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:25:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehdCm-0002tP-Im
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:24:44 -0500
Date: Fri, 2 Feb 2018 15:24:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180202152433.GC2590@work-vm>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-14-brijesh.singh@amd.com>
	<20180201175802.GK2457@work-vm>
	<7c3c7a89-04ef-016e-c9a5-4f4d4be1c449@amd.com>
	<20180201200442.GQ2457@work-vm> <20180202130817.GE15403@redhat.com>
	<3e6cf550-9bd8-daa7-e54a-d390354ffcb0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3e6cf550-9bd8-daa7-e54a-d390354ffcb0@amd.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 13/23] hmp: display memory encryption
 support in 'info kvm'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
>=20
>=20
> On 2/2/18 7:08 AM, Daniel P. Berrang=E9 wrote:
> > On Thu, Feb 01, 2018 at 08:04:43PM +0000, Dr. David Alan Gilbert wrot=
e:
> >> * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >>>
> >>> On 2/1/18 11:58 AM, Dr. David Alan Gilbert wrote:
> >>>> * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >>>>> update 'info kvm' to display the memory encryption support.
> >>>>>
> >>>>> (qemu) info kvm
> >>>>> kvm support: enabled
> >>>>> memory encryption: disabled
> >>>> As Markus said, this should be split qmp/hmp; but something else t=
o
> >>>> think about is whether this is a boolean or needs to be an enum;  =
do
> >>>> you have one version of encryption or are we going to need to flag=
 up
> >>>> versions or the features of the encryption?
> >>> In future I could see us providing encrypted state status when we
> >>> implement SEV-ES support, something like
> >>>
> >>> (qemu) info kvm
> >>> kvm support: enabled
> >>> memory encryption: enabled
> >>> cpu register state: encrypted
> >>>
> >>> but so far I do not see need to provide the version string. If user
> >>> wants to know the SEV version then it can open /dev/sev device to g=
et
> >>> platform status and more.
> >> Yes, I was worried a bit more about how general that was going to be
> >> or whether we're collecting a lot of architecture specific fields he=
re.
> >> So I wondered, if it was an enum, whether that would be come:
> >>
> >> memory encryption: none
> >>
> >> memory encryption: SEV
> >>
> >> memory encryption: SEV-ES
> >>
> >> (I'm not too sure whether that's better or not, just a suggestion)
> > I wonder if it is is even appropriate to have under 'info kvm', since
> > 'info kvm' is architecture independant and SEV is specific to AMD x86=
_64
> > only. It might suggest an 'info sev' command is better ?
>=20
> The reason I kept under 'info kvm' is because now KVM has a ioctl for
> memory encryption operation, I like your suggestion for=A0 introducing
> 'info sev' -- the command can be used to provide additional SEV specifi=
c
> details (e.g SEV FW state, SEV FW version, SEV active policy etc).

Yes, that would be useful - I'm sure there's lots of information that
will be useful to display for understanding the state of SEV, e.g. the
policies etc.

Dave

> >
> > Regards,
> > Daniel
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
