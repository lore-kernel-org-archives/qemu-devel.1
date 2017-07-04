Received: from eggs.gnu.org ([2001:4830:134:3::10]:50824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSPhQ-0002YR-Tw
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSPhM-0005NO-Qn
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:25:12 -0400
References: <1497863771-24929-1-git-send-email-thuth@redhat.com>
	<20170704144600.GH4253@noname.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <72652c2b-f7a5-d662-b648-78450d2f3c5b@redhat.com>
Date: Tue, 4 Jul 2017 17:25:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170704144600.GH4253@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Add missing "@c man end"
 statements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>



On 04/07/2017 16:46, Kevin Wolf wrote:
> Am 19.06.2017 um 11:16 hat Thomas Huth geschrieben:
>> Since commit 3f2ce724f1f1 ("Move the qemu-ga description into a
>> separate chapter"), the qemu.1 man page looks pretty much screwed
>> up, e.g. the title was "qemu-ga - QEMU Guest Agent" instead of
>> "qemu-doc - QEMU Emulator User Documentation". However, that movement
>> of the gemu-ga chapter is not the real problem, it just triggered
>> another bug in the qemu-doc.texi: There are some parts in the file
>> which introduce a "@c man begin OPTIONS" section, but never close
>> it again with "@c man end". After adding the proper end tags here,
>> the title of the man page is right again and the previously wrongly
>> tagged sections now also show up correctly in the man page, too.
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Michael, do you want to take this through qemu-trivial?

FWIW, I'm sending it out tomorrow.  Already tested the pull request, but
I'd like Richard to take another look at the final version of the
TCG-disabling patches and not rush them out.

Paolo
