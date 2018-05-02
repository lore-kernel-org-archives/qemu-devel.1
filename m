Received: from eggs.gnu.org ([2001:4830:134:3::10]:43508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDrsR-0003wU-G0
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fDrsO-0000Qp-BF
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:32:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fDrsO-0000QZ-51
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:32:56 -0400
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
	<d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
	<87muxi8t2b.fsf@dusky.pond.sub.org>
	<6c49e4ab-bb40-cf20-629a-2fc5c19d8585@redhat.com>
	<87o9hy5re9.fsf@dusky.pond.sub.org>
	<2fc4e700-9222-8785-efc3-f2749be298ab@redhat.com>
	<8760462q11.fsf@dusky.pond.sub.org>
	<30f96849-0422-7441-e03d-7f340dd14141@redhat.com>
	<878t9218vl.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a862c536-fdd1-b607-b1d5-8265589f3506@redhat.com>
Date: Wed, 2 May 2018 15:32:53 +0200
MIME-Version: 1.0
In-Reply-To: <878t9218vl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 02/05/2018 15:31, Markus Armbruster wrote:
>> We do have infrastructure for class properties, we just don't use it much.
> ... the sane thing to do would be to limit this command to class
> properties, and use class properties for anything that doesn't *have* to
> be dynamic.  The second half of the sane thing looks like a substantial
> chunk of work, though.

It's not that big, but somebody has to focus on it.

Paolo
