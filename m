Received: from eggs.gnu.org ([2001:4830:134:3::10]:57340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fG10K-0007Om-Ht
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fG10H-0007Am-Et
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:42:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fG10H-00079i-9K
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:41:57 -0400
References: <20180504160026.14017-1-berrange@redhat.com>
	<445d8704-18d2-2115-2e4c-3fcc77d8a4e4@redhat.com>
	<20180508104251.GL5967@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd10e5eb-a582-c002-9fe0-844de1650290@redhat.com>
Date: Tue, 8 May 2018 13:41:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180508104251.GL5967@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Document intent for supported build
 platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 08/05/2018 12:42, Daniel P. Berrang=C3=A9 wrote:
> On Sat, May 05, 2018 at 12:05:10AM +0200, Paolo Bonzini wrote:
>> On 04/05/2018 18:00, Daniel P. Berrang=C3=A9 wrote:
>>> Based on that doc and https://repology.org/metapackage/glib/versions,
>>> I identified that we could feasibly set min glib to 2.42. Note that
>>> this would be dropping RHEL-6 as a build host (RHEL-6.0 came out in
>>> 2010 so that's reasonable to drop IMHO). It would still cover 2 major
>>> Debian versions and 2 most recent Ubuntu LTS (16.04, 18.04, but *not*
>>> 14.04). This min glib lets us remove almost all our compat code.
>>
>> Queued after adding to patch 3 the removal of CentOS 6 and min-glib
>> Dockerfiles.
>=20
> I assume you also fixed the silly  s/GMuttex/GMutex/ typo that patchew
> and Eric pointed out in patch 2....

Yes, of course, though that was after sending the message. :)

Paolo
