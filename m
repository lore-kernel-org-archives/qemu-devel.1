Received: from eggs.gnu.org ([2001:4830:134:3::10]:50469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dDDmP-00044e-DP
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ianloic@google.com>) id 1dDDmO-00045D-Et
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:39:33 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ianloic@google.com>) id 1dDDmO-000453-71
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:39:32 -0400
Received: by mail-wm0-x236.google.com with SMTP id e127so39658301wmg.1
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 10:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20170522180217.18234-1-ianloic@google.com>
	<1495533796.30747.2.camel@redhat.com>
	<CA+YAivh=GjS5P_3BXccj5tYSxNSQoHQfeTvjgCQfVtw5QwY=_A@mail.gmail.com>
In-Reply-To: <CA+YAivh=GjS5P_3BXccj5tYSxNSQoHQfeTvjgCQfVtw5QwY=_A@mail.gmail.com>
From: Ian McKellar <ianloic@google.com>
Date: Tue, 23 May 2017 17:39:18 +0000
Message-ID: <CA+YAiviJq3VSLR1yCD9Yob7xb5z60Gw59mrSLL1+qFrtnv7OUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, May 23, 2017 at 8:52 AM Ian McKellar <ianloic@google.com> wrote:

> On Tue, May 23, 2017 at 3:03 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>>
>> I'm wondering whenever we should just use modifierFlags all the time.
>>
>
> Probably. My initial patch tried to be minimally intrusive but I can try
> reworking the NSEventTypeFlagsChanged handling to compare the new
> modifierFlags to the last we've seen and synthesize the appropriate key
> down/up events.
>
> After a little more experimentation I think that the approach in this
patch is the right one. modifierFlags doesn't[1] indicate which instance of
a modifier (ie: left or right) is being held. Except for
the NSEventTypeFlagsChanged that's synthesized when a window takes focus
the event's keyCode indicates which physical key is affected. That first
event after focus has keyCode==0 which we can detect because 0 is the
keyCode of the 'A' key which isn't a modifier.

Ian

[1] actually there are undocumented flags outside the
NSEventModifierFlagDeviceIndependentFlagsMask mask that indicate left/right
keys but I don't think we should use them.
