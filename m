Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fAgTC-0002AE-1v
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fAgT8-0002Ar-W4
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:45:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fAgT8-0002Ah-Rt
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 14:45:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6ADA3401DEB2
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 18:45:42 +0000 (UTC)
References: <20180420231246.23130-1-lersek@redhat.com>
	<20180420231246.23130-2-lersek@redhat.com>
	<87tvs2ntar.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e3eb5004-90b3-ff43-d903-8f42c94da133@redhat.com>
Date: Mon, 23 Apr 2018 20:45:35 +0200
MIME-Version: 1.0
In-Reply-To: <87tvs2ntar.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu RFC v3 1/3] qapi: add SysEmuTarget to
 "common.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Thomas Huth <thuth@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>

On 04/23/18 11:52, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> We'll soon need an enumeration type that lists all the softmmu targets
>> that QEMU (the project) supports. Introduce @SysEmuTarget to
>> "common.json".
>>
>> Cc: "Daniel P. Berrange" <berrange@redhat.com>
>> Cc: David Gibson <dgibson@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Kashyap Chamarthy <kchamart@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks! I think I'll post a PATCH (not RFC) series next, with patches #1
and #2 from this set (addressing your comments for patch #2), and I'll
try to add patch #3 for your earlier comments here:

http://mid.mail-archive.com/87k1t1sujh.fsf@dusky.pond.sub.org

And we can keep the firmware.json RFC separate, and dependent on that set.

Thanks!
Laszlo
