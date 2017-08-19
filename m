Received: from eggs.gnu.org ([2001:4830:134:3::10]:43225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dj6iP-0001sn-Pj
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 12:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dj6iL-0007W2-Hf
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 12:35:12 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dj6iL-0007PW-AM
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 12:35:09 -0400
Received: by mail-wr0-f179.google.com with SMTP id f8so35919655wrf.3
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 09:35:04 -0700 (PDT)
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
Date: Sat, 19 Aug 2017 18:34:59 +0200
MIME-Version: 1.0
In-Reply-To: <e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/13] tests: Rely more on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>

On 18/08/2017 23:33, John Snow wrote:
>> Before the next few patches
>> get rid of the qtest_* layer, we first need to update the remaining
>> few spots that were using the long form where we can instead rely
>> on the short form.
>>
> Not a big fan of globals and implicit state, but I do at least agree
> that we don't need two sets of functions.

I agree with using the short form where possible, but I disagree on
removing the long forms.  Rather, global_qtest in my opinion should have
been static (though I'm not proposing that you do this); inlining the
wrappers is not needed for performance.

Paolo
