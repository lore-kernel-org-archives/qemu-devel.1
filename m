Received: from eggs.gnu.org ([2001:4830:134:3::10]:41343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4bd-0002gD-1A
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4bZ-0000S5-Re
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:25:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo4bZ-0000Rn-Bk
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:25:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so7803348wrt.11
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 03:25:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
	<a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
	<20180809165549.5c92d5f4.olaf@aepfle.de>
	<dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
Message-ID: <840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
Date: Fri, 10 Aug 2018 12:25:09 +0200
MIME-Version: 1.0
In-Reply-To: <dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/08/2018 17:03, Paolo Bonzini wrote:
> On 09/08/2018 16:55, Olaf Hering wrote:
>>
>>> I think the simplest fix is for the map
>>> cache to set aside a zero page and return it whenever it is asked for a
>>> ballooned page.
>> Can qemu actually know if it ran into a ballooned page? I think no.
> 
> Well, xen_map_cache knows that it has run into *something like* a
> ballooned page when it returns NULL. :)

... however, that works for reading to the page, not writing.  The
problem is that your patch is incomplete.  There are many more callers
of qemu_ram_ptr_length, and none of them check the result.

Paolo
