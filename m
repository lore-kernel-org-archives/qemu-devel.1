Received: from eggs.gnu.org ([2001:4830:134:3::10]:33497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eB1j9-00056H-Tg
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 12:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eB1j5-0000yq-2a
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 12:55:23 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:47177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eB1j4-0000yT-Rh
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 12:55:18 -0400
Received: by mail-wm0-x234.google.com with SMTP id r196so6678494wmf.2
	for <qemu-devel@nongnu.org>; Sat, 04 Nov 2017 09:55:18 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171103075753.23217-1-kraxel@redhat.com>
	<20171104100908.GS4167@stuge.se>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ac142da5-657a-72dc-ec72-17bd3050d39b@redhat.com>
Date: Sat, 4 Nov 2017 17:55:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171104100908.GS4167@stuge.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] [PATCH] Ignore sgabios rom in case
 sercon is enabled.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Stuge <peter@stuge.se>, Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios@seabios.org, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On 04/11/2017 11:09, Peter Stuge wrote:
>> +        if (strcmp(file->name, "vgaroms/sgabios.bin") == 0 &&
>> +            CONFIG_SERCON && romfile_loadint("etc/sercon-port", 0)) {
>> +            dprintf(1, "sercon: is enabled, not loading sgabios rom.\n");
>> +            continue;
>> +        }
> This heuristic isn't very reliable. Is there nothing in the sgabios.bin
> option ROM itself that can be used instead?

In what sense it is not very reliable?

Paolo
