Received: from eggs.gnu.org ([2001:4830:134:3::10]:45697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6pA-0008Ln-UT
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6ov-0003Ly-1z
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:15:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gK6os-000349-9I
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:15:23 -0500
References: <1541019806-17696-1-git-send-email-george.kennedy@oracle.com>
	<a02c97ee-964b-45da-e585-ed1d190ed591@redhat.com>
	<5BE1E7D7.7020006@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13433232-aa9b-2bf3-a60c-a589f7e83682@redhat.com>
Date: Tue, 6 Nov 2018 20:15:12 +0100
MIME-Version: 1.0
In-Reply-To: <5BE1E7D7.7020006@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] lsi_scsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: george kennedy <george.kennedy@oracle.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, boris.ostrovsky@oracle.com

On 06/11/2018 20:13, george kennedy wrote:
>=20
> On 11/6/2018 1:58 PM, Paolo Bonzini wrote:
>> On 31/10/2018 22:03, George Kennedy wrote:
>>> +#define SCRIPTS_LOAD_AND_STORE=C2=A0 0xe2340004
>> I'm very confused.=C2=A0 Why did this constant reappear?
>=20
> Ok. Me too.
>=20
> What are you proposing instead and I'll change it to that?
>=20
> Did I have what you're after in a prior patch? If so, can you point to
> that clip?

No.  You need to do what you're doing here after the WAIT DISCONNECT
command (which, as far as I can see, comes before the LOAD AND STORE
you're looking for).  I wrote that in the reply to v3 I think.

Paolo
