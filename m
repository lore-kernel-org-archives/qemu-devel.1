Received: from eggs.gnu.org ([2001:4830:134:3::10]:51174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5aLW-00050z-BB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5aLR-0000yZ-CM
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:08:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5aLR-0000vX-5u
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:08:09 -0400
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
	<f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
	<df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
	<ac13fd46-bd6e-6a8a-2c72-cc8d683d5026@redhat.com>
	<87pofrfgl3.fsf@dusky.pond.sub.org>
	<93de273c-9a3b-dcb8-dd6e-8b9b4fb09a65@redhat.com>
	<176d87e9-d899-792f-536e-07cd6f5c7cb6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aaf61270-5ea0-d805-4d78-3994b03bb34d@redhat.com>
Date: Tue, 2 May 2017 18:08:03 +0200
MIME-Version: 1.0
In-Reply-To: <176d87e9-d899-792f-536e-07cd6f5c7cb6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



On 02/05/2017 17:53, Thomas Huth wrote:
>>>
>>> What we've done before for options that have become unloved, but not
>>> harmful, is remove them just from documentation.  Grep qemu-options.h=
x
>>> for "HXCOMM Deprecated".  Let's do that for --enable-kvm and similarl=
y
>>> weird sugared options.
>> Except that this provides no easily greppable way to find how to enabl=
e
>> KVM, as things stand.
> Should we then improve the description of the -accel parameter?

Yes, having a list of accelerators would be useful.  For example:

   -accel tcg[,threads=3Don|off]  ....
   -accel kvm
   -accel hax
   -accel qtest

>> So the first lesson should be "no deprecation
>> without documentation" (any reference to 18th century political slogan=
s
>> is purely coincidential :)).
> Would you accept my patch if I'd remove the hunks for vl.c, i.e. a patc=
h
> that just updates the documentation?

No, updating the documentation is pointless if you don't improve it at
the same time.

I don't like writing it so often, especially to someone who is a
relatively experienced contributor, but the common word in all these
reviews is "pointless".  What is the *purpose* of this work?

I think a valid purpose would be to improve documentation, for example.

Another would be to consolidate non-QemuOpts command-line options.  For
this, some options that are entirely internal provide interesting
grounds for improvement.  For example, "-qtest" and "qtest-log" could be
consolidated in "-qtest [chardev=3D]chardev,log=3Dfile".

Paolo
