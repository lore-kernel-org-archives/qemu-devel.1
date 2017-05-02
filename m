Received: from eggs.gnu.org ([2001:4830:134:3::10]:59980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5ZR1-0001NF-VX
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5ZQy-0002a7-N3
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:09:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d5ZQy-0002ZR-GP
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:09:48 -0400
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
	<f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
	<df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
	<ac13fd46-bd6e-6a8a-2c72-cc8d683d5026@redhat.com>
	<87pofrfgl3.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93de273c-9a3b-dcb8-dd6e-8b9b4fb09a65@redhat.com>
Date: Tue, 2 May 2017 17:09:42 +0200
MIME-Version: 1.0
In-Reply-To: <87pofrfgl3.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Vincent Palatin <vpalatin@chromium.org>



On 02/05/2017 17:01, Markus Armbruster wrote:
>> But I really, really see no point in removing --enable-kvm.  It costs
>> perhaps 10 lines of code that has pretty much no ramifications elsewhere
>> in the code.  If anything I'd expect "-machine accel" to disappear
>> before, if ever (in favor of multiple "-accel" options, e.g. "-machine
>> accel=kvm:tcg" can become "-accel kvm -accel tcg".
> I basically agree, except I wouldn't say "no point", but "doesn't buy us
> enough to justify inconveniencing users".
> 
> What we've done before for options that have become unloved, but not
> harmful, is remove them just from documentation.  Grep qemu-options.hx
> for "HXCOMM Deprecated".  Let's do that for --enable-kvm and similarly
> weird sugared options.

Except that this provides no easily greppable way to find how to enable
KVM, as things stand.  So the first lesson should be "no deprecation
without documentation" (any reference to 18th century political slogans
is purely coincidential :)).

Paolo
