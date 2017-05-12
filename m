Received: from eggs.gnu.org ([2001:4830:134:3::10]:40376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1d9BQW-0007QE-Mj
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1d9BQT-000357-K6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:20:16 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:35292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1d9BQT-00034f-E7
	for qemu-devel@nongnu.org; Fri, 12 May 2017 10:20:13 -0400
Received: by mail-io0-x22a.google.com with SMTP id f102so40822047ioi.2
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 07:20:11 -0700 (PDT)
Received: from [172.16.108.54] ([75.102.139.83])
	by smtp.googlemail.com with ESMTPSA id
	h76sm1620715ith.24.2017.05.12.07.20.08 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 May 2017 07:20:10 -0700 (PDT)
From: Rob Landley <rob@landley.net>
Message-ID: <dcc8c16f-7d4d-3fdf-a1e8-508548239bb1@landley.net>
Date: Fri, 12 May 2017 09:20:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] multiple -append?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When I feed a second -append to qemu-system-i386 they don't get
concatenated, the second replaces the first. Why is it called "append" then?

Rob
