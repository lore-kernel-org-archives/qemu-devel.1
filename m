Received: from eggs.gnu.org ([2001:4830:134:3::10]:59314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f48Ip-0002oP-0j
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f48Io-0000di-9h
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:03:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f48Io-0000dZ-4H
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:03:58 -0400
References: <20180327211451.14647-1-danielhb@linux.vnet.ibm.com>
	<9bb77420-4a76-6a1b-3542-4205fcc8334b@redhat.com>
	<f5297ff7-81aa-c2ac-9573-2b10ec7412a7@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da6b015e-bebb-406f-2809-1e7284bc9c82@redhat.com>
Date: Thu, 5 Apr 2018 19:03:53 +0200
MIME-Version: 1.0
In-Reply-To: <f5297ff7-81aa-c2ac-9573-2b10ec7412a7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/1] hw/scsi: support SCSI-2 passthrough
 without PI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 05/04/2018 18:09, Daniel Henrique Barboza wrote:
>>>
>> This also has to check for "s->qdev.scsi_version !=3D -1" so that the
>> behavior of emulated SCSI isn't changed (they claim SPC-3).=C2=A0 I ma=
de this
>> change and queued the patch.
>=20
> Good catch.

Since there were some more changes for emulated devices, I sent out a
v4.  Thanks,

Paolo
