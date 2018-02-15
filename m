Received: from eggs.gnu.org ([2001:4830:134:3::10]:41983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emEPq-0007Je-7p
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 02:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1emEPm-0006gz-Ch
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 02:57:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54218
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1emEPm-0006gI-6i
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 02:57:10 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1F7iuUw132065
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 02:57:09 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g55k21mf2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 02:57:08 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 15 Feb 2018 07:57:07 -0000
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-7-git-send-email-walling@linux.vnet.ibm.com>
	<a7e79b24-7baa-2a8b-0659-cb03c68c75fd@linux.vnet.ibm.com>
	<f97e6b7b-0765-c12b-b93d-a42470e470e2@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 08:57:02 +0100
MIME-Version: 1.0
In-Reply-To: <f97e6b7b-0765-c12b-b93d-a42470e470e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <c83f0a28-4f6c-31a9-cde7-2297258ff69a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 06/12] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 15.02.2018 07:38, Thomas Huth wrote:
> On 14.02.2018 18:46, Collin L. Walling wrote:
>> I'm beginning to like the usage of splash-time to represent a timeout
>> for the boot menu
>> less and less.=C2=A0 It is really meant for how long a _splash_ _image=
_
>> should appear during boot.
>>
>> I'd like to suggest adding a new boot option "menu-timeout".=C2=A0 An
>> alternative would be
>> documenting in qemu-options.hx that s390 treats "splash-time" as the
>> menu-timeout.
>>
>> Thoughts?
>=20
> I think you should keep splash-time and not introduce a new option.
> Libvirt seems to map the timeout from <bootmenu enable=3D'yes'
> timeout=3D'X'/> to the splash-time option, and according to the libvirt
> documentation: "Additional attribute timeout takes the number of
> milliseconds the boot menu should wait until it times out."
>=20
> So it seems like splash-time is already expected to define the amount o=
f
> time for the boot menu. We should not confuse libvirt or the users by
> introducing yet another option here.
I agree, the QEMU option name was probably poorly chosen, as it really
describes the time a user has to interact with the BIOS before it starts
booting the OS.

BTW: we could have a nice ASCII art splash image (nah ... just kidding)

 #####        #  #####   #####    ###
#     #      #  #     # #     #  #   #
#           #         # #     # #     #
 #####     #     #####   ###### #     #
      #   #           #       # #     #
#     #  #      #     # #     #  #   #
 #####  #        #####   #####    ###

[...]

--=20
Regards,
 Viktor Mihajlovski
