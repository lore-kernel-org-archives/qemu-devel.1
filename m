Received: from eggs.gnu.org ([2001:4830:134:3::10]:48722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDoMi-0004WC-CU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDoMd-0000DW-FZ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:48:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fDoMd-0000Cv-6M
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:47:55 -0400
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
	<d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
	<87muxi8t2b.fsf@dusky.pond.sub.org>
	<6c49e4ab-bb40-cf20-629a-2fc5c19d8585@redhat.com>
	<87o9hy5re9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2fc4e700-9222-8785-efc3-f2749be298ab@redhat.com>
Date: Wed, 2 May 2018 11:47:45 +0200
MIME-Version: 1.0
In-Reply-To: <87o9hy5re9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 02/05/2018 11:38, Markus Armbruster wrote:
>>>> It probably is not unless someone adds properties in realize() callb=
ack,
>>> Now work that into the doc comment, please :)
>> Are there any examples?
> There must be examples where instances of the same type have different
> properties, or else our design decision to create properties dynamicall=
y
> was inane.

Buses for example create properties at runtime to link a parent to its
children.  These properties are created when a child device appears;
this is different from creating properties in or the realize() callback,
or upon setting other properties.

The purpose of this command is to tell people/tools what they can pass
to -device/-object/device_add/object_add, so the real question is
whether there are cases where it falls short of that purpose.

If not, maybe the wording for the .json file could be something like:

  Objects can create properties at runtime, for example to describe
  links between different devices and/or objects.  These properties
  are not included in the output of this command.

Paolo
