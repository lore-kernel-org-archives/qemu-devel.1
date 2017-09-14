Received: from eggs.gnu.org ([2001:4830:134:3::10]:52687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsSSl-0005WD-UB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsSSh-0005mk-2Z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:37:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsSSg-0005lU-SV
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:37:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2A9D5F73A
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:37:37 +0000 (UTC)
References: <20170913120937.5645-1-kraxel@redhat.com>
	<20170913120937.5645-3-kraxel@redhat.com>
	<47d72e62-8ebb-3b45-3efe-ab5f98ed4f39@redhat.com>
	<1505378205.31557.3.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67d1511b-a3aa-7c59-35f8-133bac9cc5cc@redhat.com>
Date: Thu, 14 Sep 2017 13:37:30 +0200
MIME-Version: 1.0
In-Reply-To: <1505378205.31557.3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] Add --firmwarepath to configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 14/09/2017 10:36, Gerd Hoffmann wrote:
>   Hi,
> 
>>> +  --firmwarepath=PATH      search PATH for firmware files
>>
>> Maybe --firmwaredir or --with-firmwaredir (because firmwaredir is not
>> one of the "standard" directories)?
> 
> I've intentionally named this "path" because it can actually have
> multiple directories.
> 
> Or do you mean something else?  If so --verbose please.

No, you're right.

Paolo

>>> +    /* add configured firmware directories */
>>> +    dirs = g_strsplit(CONFIG_QEMU_FIRMWAREPATH, ":", 0);
>>
>> Windows probably wants to use ; here, so you can use
>> G_SEARCHPATH_SEPARATOR_S instead of ":".
> 
> Ah, cool, didn't know this exists.  Fixing ...
> 
> cheers,
>   Gerd
> 
