Received: from eggs.gnu.org ([2001:4830:134:3::10]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e2xEf-00028i-4i
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e2xEb-0004H3-2G
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:30:33 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:37390
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1e2xEa-0004FR-M7
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 06:30:28 -0400
References: <afc33ce4-c9ab-9b35-38ec-80b16642ef00@weilnetz.de>
	<20171013113708.2dd02a17.cohuck@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <a41c36b4-23a0-41cc-992e-e9b1eb5367b0@weilnetz.de>
Date: Fri, 13 Oct 2017 12:30:32 +0200
MIME-Version: 1.0
In-Reply-To: <20171013113708.2dd02a17.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] German BSI analysed security of KVM / QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developer <qemu-devel@nongnu.org>

Am 13.10.2017 um 11:37 schrieb Cornelia Huck:
> On Fri, 13 Oct 2017 11:10:05 +0200
> Stefan Weil <sw@weilnetz.de> wrote:
>
>> Hi,
>>
>> the German Bundesamt f=C3=BCr Sicherheit in der Informationstechnik
>> (Federal Office for Information Security) published a study on
>> the security of KVM and QEMU:
>>
>> https://www.bsi.bund.de/DE/Publikationen/Studien/Sicherheitsanalyse_KV=
M/sicherheitsanalyse_kvm.html
>>
>> (article only available in German)
> Thanks for posting this!
>
> I only looked at the conclusion for now. Some interesting points:
>
> - They state that QEMU's source code is well structured, readable and
>   maintainable. I wonder what kind of source code they usually deal
>   with ;)
> - Most problems noted seemed to be related to signed<->unsigned
>   conversions, but none were found to be exploitable.
> - They liked hardening via stack protection, NX, and ASLR, as well as
>   the mechanisms used by libvirt.
> - They generally seemed to be happy with QEMU being deployed via
>   libvirt.
> - Restrictions imposed via KVM (guest access to some CPU registers)
>   scored positive points. They did not like that Hyper-V and PMU were
>   not deconfigurable.
> - Lack of support for encryption/signing of network-based images was
>   criticized. They ended up using Ceph and GlusterFS, which they were
>   reasonably happy with.
>
> That's just from a quick browse.


I already found some weaknesses in the study:

* It makes the wrong assumption that all maintainers have write access
to the git repository. (chapter 5.3)
* It does not mention important quality measures like Coverity Scan,
Continuous Integration and automated tests.

So QEMU is even better than the BSI thinks. :-)

Stefan
