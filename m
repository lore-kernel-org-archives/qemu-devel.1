Received: from eggs.gnu.org ([2001:4830:134:3::10]:48184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9Rav-0001Kn-8u
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9Rau-0000rF-E7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:40:37 -0400
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-4-git-send-email-thuth@redhat.com>
	<bc5533dc-9471-7dac-6aba-9014e9961376@linux.vnet.ibm.com>
	<b0bb6918-0047-9a53-b03f-bff5669daaaa@redhat.com>
	<2d59a139-3bdd-4b4e-882c-5cf845488eda@linux.vnet.ibm.com>
	<475ea222-cc03-16e4-0f50-f89cf2bfae6f@redhat.com>
	<0b6af02e-6e5b-76bb-a0d0-30038ad5a265@linux.vnet.ibm.com>
	<a001b146-7091-63e6-a845-e276494cc518@redhat.com>
	<ca20b91c-e92f-e539-590b-fcaa229a57d5@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5a1b191-7d13-0738-4284-414b68883a6e@redhat.com>
Date: Fri, 20 Apr 2018 10:40:25 +0200
MIME-Version: 1.0
In-Reply-To: <ca20b91c-e92f-e539-590b-fcaa229a57d5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.13 3/4]
 pc-bios/s390-ccw/net: Add support for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 20.04.2018 09:54, Viktor VM Mihajlovski wrote:
> On 20.04.2018 09:36, Thomas Huth wrote:
>> On 20.04.2018 08:53, Viktor VM Mihajlovski wrote:
>>> On 19.04.2018 18:55, Thomas Huth wrote:
> [...]
>>> Well, if we don't add another identifier, and I feel reluctant about =
it
>>> as well for the reasons you wrote, we may stick with 0x1f and conside=
r
>>> the additional capabilities as being optional (for special needs only=
).
>>
>> I tend to stay with 0x1f, since booting binaries is still the "primary=
"
>> interface (the first check for the "default" or "# " magic keywords is
>> not 100% reliable, since the config file could also start with another
>> command, and the probing of pxelinux.cfg/* files is only tried afterwa=
rds).
>>
> Good. It would be important though to define and document the best way
> to configure a pxelinux setup: empty bootfile name, bootfile empty (or
> not existent) or a special file format for the bootfile content (like
> 'PXE0' in EBCDIC). The former two carry the danger of accidentally
> enabling the pxe-style boot process.

I don't like the idea of providing a bootfile with a magic content ...
if you have to provide a bootfile, you could also go with specifying
pxelinux.cfg/default (or whatever) directly, you just have to make sure
that the file starts with the right magic ("default" or "# ").

But I agree that starting to guess the non-MAC-based filenames in case
the boot file name is empty carries some danger, indeed. If we load
pxelinux.cfg/default on s390x, who guarantees that this was not the
default file for x86 instead? Maybe we should rather use "pzelinux.cfg"
as directory ;-) ?

Or maybe it would rather make sense to force the users to specify the
path to the pxelinux config files instead, ending with a slash, so they
have to put "pxelinux.cfg/" or whatever location into the bootfile
parameter?

 Thomas
