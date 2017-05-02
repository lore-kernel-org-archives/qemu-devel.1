Received: from eggs.gnu.org ([2001:4830:134:3::10]:55908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5aZm-0004DD-VU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5aZk-0002XG-Sq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:22:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5aZk-0002Vx-Mv
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:22:56 -0400
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
	<f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
	<df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
	<ac13fd46-bd6e-6a8a-2c72-cc8d683d5026@redhat.com>
	<87pofrfgl3.fsf@dusky.pond.sub.org>
	<93de273c-9a3b-dcb8-dd6e-8b9b4fb09a65@redhat.com>
	<176d87e9-d899-792f-536e-07cd6f5c7cb6@redhat.com>
	<aaf61270-5ea0-d805-4d78-3994b03bb34d@redhat.com>
	<12a970d6-591b-5684-8ae0-e043071ced9b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64215e6a-ce86-073c-ae8c-08f3bf7d5615@redhat.com>
Date: Tue, 2 May 2017 18:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <12a970d6-591b-5684-8ae0-e043071ced9b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Vincent Palatin <vpalatin@chromium.org>



On 02/05/2017 18:19, Thomas Huth wrote:
>> I don't like writing it so often, especially to someone who is a
>> relatively experienced contributor, but the common word in all these
>> reviews is "pointless".  What is the *purpose* of this work?
>
> Marking the -enable-xxx options in the documentation as deprecated would
> maybe at least prevent that we end up with more
> -enable-mynewcoolaccelerator options in the future, like we did with
> -enable-hax now.

That assumes -enable-hax was a mistake. :)

> But ok, I got the message, and I'll shut up here now. Sorry for wasting
> your time.

That absolutely wasn't the intent, sorry.  The intent is to make your
efforts more useful.

Paolo
